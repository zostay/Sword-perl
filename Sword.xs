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
	    // FIXME (*module).first is a SWBuf... no idea what that is yet...
	    // so I'm going to ignore it for now... :-D
	    SWModule *swmod = (*module).second;
            SV *module = newSV(0);
	    sv_setref_pv(module, "Sword::Module", (void *)swmod);
            av_push(RETVAL, module);
        }

    OUTPUT:
        RETVAL

Sword_Module *
Sword_Manager::get_module(const char *name)
    CODE:
        RETVAL = THIS->getModule(name);
        if (!RETVAL) XSRETURN_UNDEF;
    
    OUTPUT:
        RETVAL

MODULE = Sword                  PACKAGE = Sword::Module

const char *
Sword_Module::name(const char *name = 0)
    CODE:
	if (name)
	    RETVAL = THIS->Name(name);
	else
	    RETVAL = THIS->Name();
    OUTPUT:
	RETVAL

const char *
Sword_Module::description(const char *description = 0)
    CODE:
	if (description)
	    RETVAL = THIS->Description(description);
	else 
	    RETVAL = THIS->Description();
    OUTPUT:
	RETVAL

const char *
Sword_Module::type(const char *type = 0)
    CODE:
	if (type)
	    RETVAL = THIS->Type(type);
	else 
	    RETVAL = THIS->Type();
    OUTPUT:
	RETVAL

void
Sword_Module::set_key(const char *key)
    CODE:
        THIS->setKey(key);

const char *
Sword_Module::render_text()
    CODE:
        RETVAL = THIS->RenderText();
    OUTPUT:
        RETVAL

