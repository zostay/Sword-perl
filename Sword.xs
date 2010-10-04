#include <swmgr.h>
#include <swmodule.h>
#include <markupfiltmgr.h>

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

using namespace sword;

typedef SWMgr    Sword_Manager;
typedef SWModule Sword_Module;

MODULE = Sword                  PACKAGE = Sword::Manager

Sword_Manager *
Sword_Manager::new()
    CODE:
        RETVAL = new SWMgr(new MarkupFilterMgr(FMT_PLAIN));
    OUTPUT:
        RETVAL

AV *
Sword_Manager::modules()
    CODE:
        RETVAL = newAV();

        ModMap::iterator module;
        for (module = THIS->Modules.begin(); module != THIS->Modules.end(); ++module) {
            SV *name = newSVpv((*module).second->Name(), 0);
            av_push(RETVAL, name);
        }

    OUTPUT:
        RETVAL

Sword_Module *
Sword_Manager::module(const char *name)
    CODE:
        RETVAL = THIS->getModule(name);
        if (!RETVAL) XSRETURN_UNDEF;
    
    OUTPUT:
        RETVAL

MODULE = Sword                  PACKAGE = Sword::Module

const char *
Sword_Module::lookup_text(const char *key)
    CODE:
        THIS->setKey(key);
        RETVAL = THIS->RenderText();
    OUTPUT:
        RETVAL

