/**
 * Copyright © 2026, PhotoStructure Inc. All rights reserved.
 *
 * BY USING THIS SOFTWARE, YOU ACCEPT ALL OF THE TERMS IN
 * https://photostructure.com/eula
 * IF YOU DO NOT ACCEPT THESE TERMS, DO NOT USE THIS SOFTWARE
 */
import{d as f,a2 as g,j as k}from"./Blank.js";import{d as p,f as S,o as r,k as c,g as y,A as b,j as v,l as z,_ as C,u as A,t as B,q as l,c as o,E as _}from"./fetchApi.js";import{a as I,b as q,d as x,e as L,t as P,D as w}from"./app.js";function M(s,e){e??=new URLSearchParams;for(const[t,a]of g(s))e.set(t,a);return e}function R(s,e){const a=M(s,e).toString();return f(a)?"":"?"+a}const T={key:0,class:"thumb transparent",src:"/images/clear-64.png"},j={key:0,class:"duration"},U=p({__name:"AssetThumb",props:{id:{},aClass:{},imgClass:{},lazy:{type:Boolean},replace:{type:Boolean}},setup(s){const e=s,t=I(),{thumbSize:a,thumbFit:n}=S(t),u=o(()=>!k(q(e.id))),m=o(()=>n.value==="square"),d=o(()=>m.value?x({assetId:e.id,lazyLoad:e.lazy,size:a.value}):L({assetId:e.id,lazyLoad:e.lazy,widths:[P(a.value)],reducer:"fit"})),i=o(()=>w({assetId:e.id}));return(D,E)=>{const h=_("router-link");return u.value?(r(),c("img",T)):i.value.href?(r(),y(h,{key:1,to:i.value.href,class:b(s.aClass),replace:s.replace},{default:v(()=>[z("img",C({class:["thumb",s.imgClass,A(n)]},d.value),null,16),s.id.durationHMS?(r(),c("span",j,B(s.id.durationHMS),1)):l("",!0)]),_:1},8,["to","class","replace"])):l("",!0)}}});export{U as _,R as t};
