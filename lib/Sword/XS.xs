#include <swmgr.h>
#include <swmodule.h>
#include <markupfiltmgr.h>

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

using namespace sword;

MODULE = Sword                  PACKAGE = Sword::XS

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
