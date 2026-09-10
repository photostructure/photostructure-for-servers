/**
 * Copyright © 2026, PhotoStructure Inc. All rights reserved.
 *
 * BY USING THIS SOFTWARE, YOU ACCEPT ALL OF THE TERMS IN
 * https://photostructure.com/eula
 * IF YOU DO NOT ACCEPT THESE TERMS, DO NOT USE THIS SOFTWARE
 */
import{D as e,F as t,Y as n,dt as r,j as i,k as a,m as o,q as s,ut as c,w as l}from"./Spinner.js";import{O as u,T as d,d as f,f as p,p as m,v as h,y as g}from"./app.js";var _=t({__name:`AssetGallery`,props:{assetIds:{},page:{},active:{type:Boolean},sample:{type:Boolean},context:{}},setup(t){let _=t,v=m(),{thumbSize:y,thumbFit:b,viewportWidth:x,contentWidth:S}=o(v),C=d(),w=e(()=>_.active&&!C.isOpen),T=e(()=>g({viewportWidth:x.value,contentWidth:S.value,padding:h[_.page],minTileWidth:p(y.value)})),E=e(()=>[`gallery`,_.sample===!0?`sample`:`leaf`,y.value]);return(e,o)=>(s(),i(`div`,{class:r(E.value)},[(s(!0),i(l,null,n(t.assetIds,e=>(s(),a(f,{key:c(b)+`:`+c(u)(e),id:e,lazy:!0,active:w.value,context:t.context,"tile-width":T.value.tileWidth,sizes:T.value.sizes},null,8,[`id`,`active`,`context`,`tile-width`,`sizes`]))),128))],2))}});export{_ as t};