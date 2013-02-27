/*1346164611,173213213*/

if (window.CavalryLogger) { CavalryLogger.start_js(["u3Tzp"]); }

__d("ArbiterFrame",[],function(a,b,c,d,e,f){var g={inform:function(h,i,j){var k=parent.frames,l=k.length,m;i.crossFrame=true;for(var n=0;n<l;n++){m=k[n];try{if(!m||m==window)continue;if(m.require){m.require('Arbiter').inform(h,i,j);}else if(m.AsyncLoaderLazy)m.AsyncLoaderLazy.wakeUp(h,i,j);}catch(o){}}}};e.exports=g;});
__d("Plugin",["Arbiter","ArbiterFrame"],function(a,b,c,d,e,f){var g=b('Arbiter'),h=b('ArbiterFrame'),i={CONNECT:'platform/plugins/connect',DISCONNECT:'platform/plugins/disconnect',ERROR:'platform/plugins/error',connect:function(j,k){var l={identifier:j,href:j,story_fbid:k};g.inform(i.CONNECT,l);h.inform(i.CONNECT,l);},disconnect:function(j,k){var l={identifier:j,href:j,story_fbid:k};g.inform(i.DISCONNECT,l);h.inform(i.DISCONNECT,l);},error:function(j,k){g.inform(i.ERROR,{action:j,content:k});}};e.exports=i;});
__d("PluginOptin",["DOMEvent","DOMEventListener","PopupWindow","URI","bind","copyProperties"],function(a,b,c,d,e,f){var g=b('DOMEvent'),h=b('DOMEventListener'),i=b('PopupWindow'),j=b('URI'),k=b('bind'),l=b('copyProperties');function m(n){l(this,{return_params:j.getRequestURI().getQueryData(),login_params:{},optin_params:{},plugin:n});this.addReturnParams({ret:'optin'});delete this.return_params.hash;}l(m.prototype,{addReturnParams:function(n){l(this.return_params,n);return this;},addLoginParams:function(n){l(this.login_params,n);return this;},addOptinParams:function(n){l(this.optin_params,n);return this;},start:function(){var n=new j('/dialog/optin').addQueryData(this.optin_params).addQueryData({display:'popup',app_id:127760087237610,secure:j.getRequestURI().isSecure(),social_plugin:this.plugin,return_params:JSON.stringify(this.return_params),login_params:JSON.stringify(this.login_params)});this.popup=i.open(n.toString(),420,450);h.add(window,'message',function(event){if((/\.facebook\.com$/).test(event.origin))if(/^FB_POPUP:/.test(event.data)){var o=JSON.parse(event.data.substring(9));if('reload' in o)document.location.replace(o.reload);}});return this;}});m.starter=function(n,o,p,q){var r=new m(n);r.addReturnParams(o||{});r.addLoginParams(p||{});r.addOptinParams(q||{});return k(r,r.start);};m.listen=function(n,o,p,q,r){h.add(n,'click',function(s){new g(s).kill();m.starter(o,p,q,r)();});};e.exports=m;});
__d("PluginConnectButton",["Arbiter","CSS","DOM","DOMEvent","DOMEventListener","Form","Plugin","PluginOptin","copyProperties"],function(a,b,c,d,e,f){var g=b('Arbiter'),h=b('CSS'),i=b('DOM'),j=b('DOMEvent'),k=b('DOMEventListener'),l=b('Form'),m=b('Plugin'),n=b('PluginOptin'),o=b('copyProperties'),p=g.SUBSCRIBE_NEW,q=g.subscribe,r=function(t,u){return k.add(t,'click',u);};function s(t){this.config=t;var u=i.find(t.form,'.pluginConnectButton');this.buttons=u;this.node_connected=i.find(u,'.pluginConnectButtonConnected');this.node_disconnected=i.find(u,'.pluginConnectButtonDisconnected');var v=function(x){new j(x).kill();this.submit();}.bind(this);r(this.node_disconnected,v);r(i.find(u,'.pluginButtonX button'),v);var w=this.update.bind(this);q(m.CONNECT,w,p);q(m.DISCONNECT,w,p);q(m.ERROR,this.error.bind(this),p);if(t.autosubmit)this.submit();}o(s.prototype,{update:function(t,event){var u=this.config;if(event.identifier!==u.identifier)return;var v=t===m.CONNECT?true:false,w="/plugins/"+u.plugin+"/";w+=!v?"connect":"disconnect";h[v?'show':'hide'](this.node_connected);h[v?'hide':'show'](this.node_disconnected);u.connected=v;u.form.setAttribute('action',w);u.form.setAttribute('ajaxify',w);},error:function(event,t){if(t.action in {connect:1,disconnect:1})i.setContent(this.buttons,t.content);},submit:function(){if(!this.config.canpersonalize)return this.login();l.bootstrap(this.config.form);this.fireStateToggle();},fireStateToggle:function(){var t=this.config;if(t.connected){m.disconnect(t.identifier);}else m.connect(t.identifier);},login:function(){var t=this.config.plugin;new n(t).addReturnParams({act:'connect'}).start();}});e.exports=s;});
__d("PluginConnection",["Plugin","Arbiter","CSS","copyProperties"],function(a,b,c,d,e,f){var g=b('Plugin'),h=b('Arbiter'),i=b('CSS'),j=b('copyProperties'),k=function(){};j(k.prototype,{init:function(l,m,n,event){event=event||g.CONNECT;this.identifier=l;this.element=m;this.css=n;h.subscribe([g.CONNECT,g.DISCONNECT],function(o,p){if(l===p.href)i[o===event?'addClass':'removeClass'](m,n);return true;});return this;},connected:function(){return i.hasClass(this.element,this.css);},connect:function(){return h.inform(g.CONNECT,{href:this.identifier},h.BEHAVIOR_STATE);},disconnect:function(){return h.inform(g.DISCONNECT,{href:this.identifier},h.BEHAVIOR_STATE);},toggle:function(){return this.connected()?this.disconnect():this.connect();}});k.init=function(l){for(var m,n=0;n<l.length;n++){m=new k();m.init.apply(m,l[n]);}};e.exports=k;});
__d("PluginRecommendationsBar",["function-extensions","event-extensions","Arbiter","CSS","DOM","Form","Plugin","PluginConnection","PluginPerms","PluginResize","UnverifiedXD","copyProperties","curry"],function(a,b,c,d,e,f){b('function-extensions');b('event-extensions');var g=b('Arbiter'),h=b('CSS'),i=b('DOM'),j=b('Form'),k=b('Plugin'),l=b('PluginConnection'),m=b('PluginPerms'),n=b('PluginResize'),o=b('UnverifiedXD'),p=b('copyProperties'),q=b('curry');function r(){}r.ACTION='Connect.Unsafe.platform/plugins/recommendations_bar/action';r.TRIGGER='Connect.Unsafe.platform/plugins/recommendations_bar/trigger';r.CREATE_READ='platform/plugins/recommendations_bar/create_read';r.DELETE_READ='platform/plugins/recommendations_bar/delete_read';r.OPEN='platform/plugins/recommendations_bar/open';function s(u){var v=function(){v=bagof(u());};return function(){return v();};}var t=[r.ACTION,r.TRIGGER];p(r.prototype,{init:function(u,v){this.element=u;var w=new n(function(){return v.offsetWidth+2;},function(){return u.offsetHeight;});w.resize().auto();this.resizer=w;g.registerCallback(q(g.inform,r.OPEN),t);g.subscribe(r.OPEN,function(){h.addClass(u,'pluginRecommendationsBarOpen');o.send({type:'signal_animation'});w.resize();});},initReadToggle:function(u,v,w,x,y,z){Event.listen(w,'click',q(j.bootstrap,x.getRoot()));Event.listen(w,'click',u.show.bind(u,y.id));Event.listen(y,'click',q(j.bootstrap,z.getRoot()));Event.listen(y,'click',u.show.bind(u,w.id));},initPerms:function(u,v){Event.listen(u,'click',m.starter('recommendations_bar',v,['publish_actions']));},initRead:function(u){g.subscribe(r.OPEN,s(q(j.bootstrap,u.getRoot())));},initOpenLog:function(u){g.subscribe(r.OPEN,s(q(j.bootstrap,u.getRoot())));},initRecommendation:function(u,v,w,x,y){var z=s(q(j.bootstrap,u.getRoot()));g.subscribe(t,z);Event.listen(x,'click',z);Event.listen(x,'click',q(h.addClass,this.element,'pluginRecommendationsBarOpen'));Event.listen(y,'click',function(event){if(w.showing()!=v){w.show(v);}else h.removeClass(this.element,'pluginRecommendationsBarOpen');this.resizer.resize();return true;}.bind(this));},initLike:function(u,v,w,x){var y=new l().init(u,v,'pluginRecommendationsBarButtonDepressed');Event.listen(v,'click',function(event){j.bootstrap((y.connected()?x:w).getRoot());y.toggle();return true;});},initError:function(u,v){g.subscribe(k.ERROR,function(event,w){i.setContent(u,w.content);v.show(u.id);h.addClass(this.element,'pluginRecommendationsBarOpen');this.resizer.resize();}.bind(this));}});e.exports=r;});
__d("PluginSend",["Arbiter","CSS","DOMDimensions","DOMPosition","DOMQuery","PluginOptin","UnverifiedXD","copyProperties"],function(a,b,c,d,e,f){var g=b('Arbiter'),h=b('CSS'),i=b('DOMDimensions'),j=b('DOMPosition'),k=b('DOMQuery'),l=b('PluginOptin'),m=b('UnverifiedXD'),n=b('copyProperties'),o='platform/socialplugins/dialog',p='platform/socialplugins/send/sent',q='platform/socialplugins/send/cancel',r=false,s=false,t={type:'presentEdgeCommentDialog',controllerID:'',widget_type:'send',nodeURL:'',width:400,height:300,query:{}},u={close:'dismissEdgeCommentDialog',show:'showEdgeCommentDialog',hide:'hideEdgeCommentDialog'},v={element:null,href:'',canpersonalize:false},w,x,y='';function z(){new l("send").addReturnParams({act:"send"}).start();}function aa(da){if(!v.canpersonalize)return z();if(typeof da!=='string')if(!r){da='open';}else if(s){da='hide';}else da='show';switch(da){case 'open':g.inform(o,{controllerID:y,event:da});r=s=true;var ea=i.getElementDimensions(x),fa=j.getElementPosition(x);t.anchorGeometry={x:ea.width,y:ea.height};t.anchorPosition={x:fa.x,y:fa.y};var ga=ba();t.query.anchorTargetX=ga.x;t.query.anchorTargetY=ga.y;m.send(t);break;case 'close':g.inform(o,{controllerID:y,event:da});r=s=false;break;case 'show':s=true;break;default:s=false;break;}h[s?'show':'hide'](w);h[s?'hide':'show'](x);if(da!=='open')m.send({type:u[da]});}function ba(){var da=k.find(x,'.pluginButtonIcon'),ea=j.getElementPosition(da),fa=i.getElementDimensions(da);return {y:ea.y+fa.width/2,x:ea.x+fa.height/2};}var ca={init:function(da){n(v,da);y=t.controllerID=v.element.id;t.nodeURL=v.href;w=k.find(v.element,'.pluginSendActive');x=k.find(v.element,'.pluginSendInactive');v.element.onclick=aa;g.subscribe(q,function(ea,fa){if(fa.controllerID===y)aa('hide');},g.SUBSCRIBE_NEW);g.subscribe(p,function(ea,fa){if(fa.controllerID===y)aa('close');},g.SUBSCRIBE_NEW);if(da.autosubmit)aa('open');}};a.Arbiter=g;e.exports=ca;});
__d("PluginStack",["CSS","DOM","copyProperties","createArrayFrom"],function(a,b,c,d,e,f){var g=b('CSS'),h=b('DOM'),i=b('copyProperties'),j=b('createArrayFrom');function k(l,m){this._container=l;this._showing=m;}i(k.prototype,{show:function(l){this.hideAll();g.show(h.find(this.container(),'#'+l));this._showing=l;return this;},hideAll:function(){this.children().forEach(g.hide,g);return this;},container:function(){return this._container;},children:function(){return j(this.container().childNodes);},showing:function(){return this._showing;}});e.exports=k;});
__d("legacy:PluginOptin-legacy",["Plugin","PluginOptin"],function(a,b,c,d){if(!a.Plugin||!a.Plugin.CONNECT)a.Plugin=b('Plugin');a.Plugin.Optin=b('PluginOptin');},3);
__d("legacy:PluginRecommendationsBar-legacy",["Plugin","PluginRecommendationsBar"],function(a,b,c,d){if(!a.Plugin||!a.Plugin.CONNECT)a.Plugin=b('Plugin');a.Plugin.RecommendationsBar=b('PluginRecommendationsBar');},3);