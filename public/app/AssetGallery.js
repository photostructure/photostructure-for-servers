/**
 * Copyright © 2026, PhotoStructure Inc. All rights reserved.
 *
 * BY USING THIS SOFTWARE, YOU ACCEPT ALL OF THE TERMS IN
 * https://photostructure.com/eula
 * IF YOU DO NOT ACCEPT THESE TERMS, DO NOT USE THIS SOFTWARE
 */
import{A as e,B as t,Dt as n,Et as r,H as i,K as a,W as o,X as s,ct as c,ut as l}from"./Spinner.js";import{M as u,a as d,i as f,m as p,o as m,p as h,v as g}from"./NavMenuButton.js";var _=s({__name:`AssetGallery`,props:{assetIds:{},page:{},active:{type:Boolean},sample:{type:Boolean},context:{},returnTo:{}},setup(s){let _=s,v=m(),{thumbSize:y,thumbFit:b,viewportWidth:x,contentWidth:S}=e(v),C=g(),w=i(()=>_.active&&!C.isOpen),T=i(()=>p({viewportWidth:x.value,contentWidth:S.value,padding:h[_.page],minTileWidth:d(y.value)})),E=i(()=>[`gallery`,_.sample===!0?`sample`:`leaf`,y.value]);return(e,i)=>(c(),a(`div`,{class:n(E.value)},[(c(!0),a(t,null,l(s.assetIds,e=>(c(),o(f,{key:r(b)+`:`+r(u)(e),id:e,lazy:!0,active:w.value,context:s.context,"return-to":s.returnTo,"tile-width":T.value.tileWidth,sizes:T.value.sizes},null,8,[`id`,`active`,`context`,`return-to`,`tile-width`,`sizes`]))),128))],2))}});export{_ as t};