/**
 * Copyright © 2026, PhotoStructure Inc. All rights reserved.
 *
 * BY USING THIS SOFTWARE, YOU ACCEPT ALL OF THE TERMS IN
 * https://photostructure.com/eula
 * IF YOU DO NOT ACCEPT THESE TERMS, DO NOT USE THIS SOFTWARE
 */
import{d as c,f as m,k as r,l as k,u as t,E as l,_ as u,B as i,o as p}from"./Touch.js";import{f as d,g as b,D as g,F as B}from"./app.js";const x=["title"],v=c({__name:"FullscreenButton",setup(_){const n=d(),{fullscreen:e}=m(n),{toggle:s}=n;return(o,a)=>t(b)?(i(),r("button",{key:0,title:t(e)?"Exit full screen":"Full screen",class:"vicon no-drag hide-on-m","data-key":"f",onClick:a[0]||(a[0]=(...f)=>t(s)&&t(s)(...f))},[l(u,{icon:t(e)?"fullscreen_exit":"fullscreen"},null,8,["icon"])],8,x)):k("",!0)}}),C=c({__name:"HeaderBackButton",setup(_){const n=g();function e(){n.back()}return(s,o)=>(i(),r("button",{title:"Go back",class:"vicon back hide-on-s","data-key":"esc","data-key2":"backspace",onClick:e},[l(u,{icon:"arrow_back"})]))}}),F=c({__name:"NavMenuButton",setup(_){const n=B(),{toggle:e}=n;return(s,o)=>(i(),r("button",{title:"Navigation",class:"vicon",onClick:o[0]||(o[0]=p((...a)=>t(e)&&t(e)(...a),["stop"])),"data-key":"m"},[l(u,{icon:"hamburger"})]))}});export{F as _,C as a,v as b};
