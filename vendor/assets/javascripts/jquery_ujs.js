!function(t,e){"use strict";t.rails!==e&&t.error("jquery-ujs has already been loaded!");var a,n=t(document);t.rails=a={linkClickSelector:"a[data-confirm], a[data-method], a[data-remote]:not([disabled]), a[data-disable-with], a[data-disable]",buttonClickSelector:"button[data-remote]:not([form]):not(form button), button[data-confirm]:not([form]):not(form button)",inputChangeSelector:"select[data-remote], input[data-remote], textarea[data-remote]",formSubmitSelector:"form",formInputClickSelector:"form input[type=submit], form input[type=image], form button[type=submit], form button:not([type]), input[type=submit][form], input[type=image][form], button[type=submit][form], button[form]:not([type])",disableSelector:"input[data-disable-with]:enabled, button[data-disable-with]:enabled, textarea[data-disable-with]:enabled, input[data-disable]:enabled, button[data-disable]:enabled, textarea[data-disable]:enabled",enableSelector:"input[data-disable-with]:disabled, button[data-disable-with]:disabled, textarea[data-disable-with]:disabled, input[data-disable]:disabled, button[data-disable]:disabled, textarea[data-disable]:disabled",requiredInputSelector:"input[name][required]:not([disabled]), textarea[name][required]:not([disabled])",fileInputSelector:"input[type=file]:not([disabled])",linkDisableSelector:"a[data-disable-with], a[data-disable]",buttonDisableSelector:"button[data-remote][data-disable-with], button[data-remote][data-disable]",csrfToken:function(){return t("meta[name=csrf-token]").attr("content")},csrfParam:function(){return t("meta[name=csrf-param]").attr("content")},CSRFProtection:function(t){var e=a.csrfToken();e&&t.setRequestHeader("X-CSRF-Token",e)},refreshCSRFTokens:function(){t('form input[name="'+a.csrfParam()+'"]').val(a.csrfToken())},fire:function(e,a,n){var r=t.Event(a);return e.trigger(r,n),r.result!==!1},confirm:function(t){return confirm(t)},ajax:function(e){return t.ajax(e)},href:function(t){return t[0].href},isRemote:function(t){return t.data("remote")!==e&&t.data("remote")!==!1},handleRemote:function(n){var r,i,o,l,s,u;if(a.fire(n,"ajax:before")){if(l=n.data("with-credentials")||null,s=n.data("type")||t.ajaxSettings&&t.ajaxSettings.dataType,n.is("form")){r=n.data("ujs:submit-button-formmethod")||n.attr("method"),i=n.data("ujs:submit-button-formaction")||n.attr("action"),o=t(n[0].elements).serializeArray();var d=n.data("ujs:submit-button");d&&(o.push(d),n.data("ujs:submit-button",null)),n.data("ujs:submit-button-formmethod",null),n.data("ujs:submit-button-formaction",null)}else n.is(a.inputChangeSelector)?(r=n.data("method"),i=n.data("url"),o=n.serialize(),n.data("params")&&(o=o+"&"+n.data("params"))):n.is(a.buttonClickSelector)?(r=n.data("method")||"get",i=n.data("url"),o=n.serialize(),n.data("params")&&(o=o+"&"+n.data("params"))):(r=n.data("method"),i=a.href(n),o=n.data("params")||null);return u={type:r||"GET",data:o,dataType:s,beforeSend:function(t,r){return r.dataType===e&&t.setRequestHeader("accept","*/*;q=0.5, "+r.accepts.script),a.fire(n,"ajax:beforeSend",[t,r])?(n.trigger("ajax:send",t),e):!1},success:function(t,e,a){n.trigger("ajax:success",[t,e,a])},complete:function(t,e){n.trigger("ajax:complete",[t,e])},error:function(t,e,a){n.trigger("ajax:error",[t,e,a])},crossDomain:a.isCrossDomain(i)},l&&(u.xhrFields={withCredentials:l}),i&&(u.url=i),a.ajax(u)}return!1},isCrossDomain:function(t){var e=document.createElement("a");e.href=location.href;var a=document.createElement("a");try{return a.href=t,a.href=a.href,!((!a.protocol||":"===a.protocol)&&!a.host||e.protocol+"//"+e.host==a.protocol+"//"+a.host)}catch(n){return!0}},handleMethod:function(n){var r=a.href(n),i=n.data("method"),o=n.attr("target"),l=a.csrfToken(),s=a.csrfParam(),u=t('<form method="post" action="'+r+'"></form>'),d='<input name="_method" value="'+i+'" type="hidden" />';s===e||l===e||a.isCrossDomain(r)||(d+='<input name="'+s+'" value="'+l+'" type="hidden" />'),o&&u.attr("target",o),u.hide().append(d).appendTo("body"),u.submit()},formElements:function(e,a){return e.is("form")?t(e[0].elements).filter(a):e.find(a)},disableFormElements:function(e){a.formElements(e,a.disableSelector).each(function(){a.disableFormElement(t(this))})},disableFormElement:function(t){var a,n;a=t.is("button")?"html":"val",n=t.data("disable-with"),n!==e&&(t.data("ujs:enable-with",t[a]()),t[a](n)),t.prop("disabled",!0),t.data("ujs:disabled",!0)},enableFormElements:function(e){a.formElements(e,a.enableSelector).each(function(){a.enableFormElement(t(this))})},enableFormElement:function(t){var a=t.is("button")?"html":"val";t.data("ujs:enable-with")!==e&&(t[a](t.data("ujs:enable-with")),t.removeData("ujs:enable-with")),t.prop("disabled",!1),t.removeData("ujs:disabled")},allowAction:function(t){var e,n=t.data("confirm"),r=!1;if(!n)return!0;if(a.fire(t,"confirm")){try{r=a.confirm(n)}catch(i){(console.error||console.log).call(console,i.stack||i)}e=a.fire(t,"confirm:complete",[r])}return r&&e},blankInputs:function(e,a,n){var r,i,o=t(),l=a||"input,textarea",s=e.find(l);return s.each(function(){if(r=t(this),i=r.is("input[type=checkbox],input[type=radio]")?r.is(":checked"):!!r.val(),i===n){if(r.is("input[type=radio]")&&s.filter('input[type=radio]:checked[name="'+r.attr("name")+'"]').length)return!0;o=o.add(r)}}),o.length?o:!1},nonBlankInputs:function(t,e){return a.blankInputs(t,e,!0)},stopEverything:function(e){return t(e.target).trigger("ujs:everythingStopped"),e.stopImmediatePropagation(),!1},disableElement:function(t){var n=t.data("disable-with");n!==e&&(t.data("ujs:enable-with",t.html()),t.html(n)),t.bind("click.railsDisable",function(t){return a.stopEverything(t)}),t.data("ujs:disabled",!0)},enableElement:function(t){t.data("ujs:enable-with")!==e&&(t.html(t.data("ujs:enable-with")),t.removeData("ujs:enable-with")),t.unbind("click.railsDisable"),t.removeData("ujs:disabled")}},a.fire(n,"rails:attachBindings")&&(t.ajaxPrefilter(function(t,e,n){t.crossDomain||a.CSRFProtection(n)}),t(window).on("pageshow.rails",function(){t(t.rails.enableSelector).each(function(){var e=t(this);e.data("ujs:disabled")&&t.rails.enableFormElement(e)}),t(t.rails.linkDisableSelector).each(function(){var e=t(this);e.data("ujs:disabled")&&t.rails.enableElement(e)})}),n.delegate(a.linkDisableSelector,"ajax:complete",function(){a.enableElement(t(this))}),n.delegate(a.buttonDisableSelector,"ajax:complete",function(){a.enableFormElement(t(this))}),n.delegate(a.linkClickSelector,"click.rails",function(n){var r=t(this),i=r.data("method"),o=r.data("params"),l=n.metaKey||n.ctrlKey;if(!a.allowAction(r))return a.stopEverything(n);if(!l&&r.is(a.linkDisableSelector)&&a.disableElement(r),a.isRemote(r)){if(l&&(!i||"GET"===i)&&!o)return!0;var s=a.handleRemote(r);return s===!1?a.enableElement(r):s.fail(function(){a.enableElement(r)}),!1}return i?(a.handleMethod(r),!1):e}),n.delegate(a.buttonClickSelector,"click.rails",function(e){var n=t(this);if(!a.allowAction(n)||!a.isRemote(n))return a.stopEverything(e);n.is(a.buttonDisableSelector)&&a.disableFormElement(n);var r=a.handleRemote(n);return r===!1?a.enableFormElement(n):r.fail(function(){a.enableFormElement(n)}),!1}),n.delegate(a.inputChangeSelector,"change.rails",function(e){var n=t(this);return a.allowAction(n)&&a.isRemote(n)?(a.handleRemote(n),!1):a.stopEverything(e)}),n.delegate(a.formSubmitSelector,"submit.rails",function(n){var r,i,o=t(this),l=a.isRemote(o);if(!a.allowAction(o))return a.stopEverything(n);if(o.attr("novalidate")===e)if(o.data("ujs:formnovalidate-button")===e){if(r=a.blankInputs(o,a.requiredInputSelector,!1),r&&a.fire(o,"ajax:aborted:required",[r]))return a.stopEverything(n)}else o.data("ujs:formnovalidate-button",e);if(l){if(i=a.nonBlankInputs(o,a.fileInputSelector)){setTimeout(function(){a.disableFormElements(o)},13);var s=a.fire(o,"ajax:aborted:file",[i]);return s||setTimeout(function(){a.enableFormElements(o)},13),s}return a.handleRemote(o),!1}setTimeout(function(){a.disableFormElements(o)},13)}),n.delegate(a.formInputClickSelector,"click.rails",function(e){var n=t(this);if(!a.allowAction(n))return a.stopEverything(e);var r=n.attr("name"),i=r?{name:r,value:n.val()}:null,o=n.closest("form");0===o.length&&(o=t("#"+n.attr("form"))),o.data("ujs:submit-button",i),o.data("ujs:formnovalidate-button",n.attr("formnovalidate")),o.data("ujs:submit-button-formaction",n.attr("formaction")),o.data("ujs:submit-button-formmethod",n.attr("formmethod"))}),n.delegate(a.formSubmitSelector,"ajax:send.rails",function(e){this===e.target&&a.disableFormElements(t(this))}),n.delegate(a.formSubmitSelector,"ajax:complete.rails",function(e){this===e.target&&a.enableFormElements(t(this))}),t(function(){a.refreshCSRFTokens()}))}(jQuery);