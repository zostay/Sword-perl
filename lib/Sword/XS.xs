#include <swmgr.h>
#include <swmodule.h>
#include <markupfiltmgr.h>

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

using namespace sword;

MODULE = Sword                  PACKAGE = Sword::XS

SWMgr *
get_library()
    CODE:
        RETVAL = new SWMgr(new MarkupFilterMgr(FMT_PLAIN));
    OUTPUT:
        RETVAL

AV *
list_modules(SWMgr *library)
    CODE:
        RETVAL = newAV();

        ModMap::iterator module;
        for (module = library->Modules.begin(); module != library->Modules.end(); ++module) {
            SV *name = newSVpv((*module).second->Name(), 0);
            av_push(RETVAL, name);
        }

    OUTPUT:
        RETVAL

SWModule *
get_module(SWMgr *library, char *name)
    CODE:
        RETVAL = library->getModule(name);
        if (!RETVAL) XSRETURN_UNDEF;
    
    OUTPUT:
        RETVAL

const char *
get_key_text(SWModule *module, char *key)
    CODE:
        module->setKey(key);
        RETVAL = module->RenderText();
    OUTPUT:
        RETVAL

SV *
kjv(SV *key)
    CODE:
        SWMgr library(new MarkupFilterMgr(FMT_PLAIN));
        SWModule *target;
        STRLEN len;

        target = library.getModule("KJV");
        if (!target) {
            XSRETURN_UNDEF;
        }
        
        target->setKey(SvPV(key, len));
        RETVAL = newSVpv(target->RenderText(), 0);
    OUTPUT:
        RETVAL
        

void
hello()
    CODE:
        printf("Hello world!\n");
