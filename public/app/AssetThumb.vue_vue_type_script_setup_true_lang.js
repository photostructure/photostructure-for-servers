/**
 * Copyright © 2026, PhotoStructure Inc. All rights reserved.
 *
 * BY USING THIS SOFTWARE, YOU ACCEPT ALL OF THE TERMS IN
 * https://photostructure.com/eula
 * IF YOU DO NOT ACCEPT THESE TERMS, DO NOT USE THIS SOFTWARE
 */
import{b as f,a1 as g,l as k}from"./Blank.js";import{d as p,f as S,c as r,k as l,g as y,l as c,F as b,z as v,j as z,m as C,a3 as A,u as B,t as I,B as o}from"./Touch.js";import{a as _,b as x,d as L,e as P,t as q,E as w}from"./app.js";function F(e,a){a??=new URLSearchParams;for(const[t,s]of g(e))a.set(t,s);return a}function V(e,a){const s=F(e,a).toString();return f(s)?"":"?"+s}const M={key:0,class:"thumb transparent",src:"/images/clear-64.png"},T={key:0,class:"duration"},j=p({__name:"AssetThumb",props:{id:{},aClass:{},imgClass:{},lazy:{type:Boolean},replace:{type:Boolean}},setup(e){const a=e,t=_(),{thumbSize:s,thumbFit:n}=S(t),u=r(()=>!k(x(a.id))),m=r(()=>n.value==="square"),d=r(()=>m.value?L({assetId:a.id,lazyLoad:a.lazy,size:s.value}):P({assetId:a.id,lazyLoad:a.lazy,widths:[q(s.value)],reducer:"fit"})),i=r(()=>w({assetId:a.id}));return(E,H)=>{const h=b("router-link");return u.value?(o(),l("img",M)):i.value.href?(o(),y(h,{key:1,to:i.value.href,class:v(e.aClass),replace:e.replace},{default:z(()=>[C("img",A({class:["thumb",e.imgClass,B(n)]},d.value),null,16),e.id.durationHMS?(o(),l("span",T,I(e.id.durationHMS),1)):c("",!0)]),_:1},8,["to","class","replace"])):c("",!0)}}});export{j as _,V as t};
