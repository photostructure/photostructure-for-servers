/**
 * Copyright © 2026, PhotoStructure Inc. All rights reserved.
 *
 * BY USING THIS SOFTWARE, YOU ACCEPT ALL OF THE TERMS IN
 * https://photostructure.com/eula
 * IF YOU DO NOT ACCEPT THESE TERMS, DO NOT USE THIS SOFTWARE
 */
import{d as c,f,u as t,k as r,F as u,q as k,o as l,m as p}from"./fetchApi.js";import{f as d,g as b,C as g,E as B}from"./app.js";import{_ as i}from"./Touch.js";const x=["title"],v=c({__name:"FullscreenButton",setup(_){const n=d(),{fullscreen:e}=f(n),{toggle:o}=n;return(s,a)=>t(b)?(l(),r("button",{key:0,title:t(e)?"Exit full screen":"Full screen",class:"vicon no-drag hide-on-m","data-key":"f",onClick:a[0]||(a[0]=(...m)=>t(o)&&t(o)(...m))},[u(i,{icon:t(e)?"fullscreen_exit":"fullscreen"},null,8,["icon"])],8,x)):k("",!0)}}),F=c({__name:"HeaderBackButton",setup(_){const n=g();function e(){n.back()}return(o,s)=>(l(),r("button",{title:"Go back",class:"vicon back hide-on-s","data-key":"esc","data-key2":"backspace",onClick:e},[u(i,{icon:"arrow_back"})]))}}),E=c({__name:"NavMenuButton",setup(_){const n=B(),{toggle:e}=n;return(o,s)=>(l(),r("button",{title:"Navigation",class:"vicon",onClick:s[0]||(s[0]=p((...a)=>t(e)&&t(e)(...a),["stop"])),"data-key":"m"},[u(i,{icon:"hamburger"})]))}});export{E as _,F as a,v as b};
