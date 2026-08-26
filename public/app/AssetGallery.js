/**
 * Copyright © 2026, PhotoStructure Inc. All rights reserved.
 *
 * BY USING THIS SOFTWARE, YOU ACCEPT ALL OF THE TERMS IN
 * https://photostructure.com/eula
 * IF YOU DO NOT ACCEPT THESE TERMS, DO NOT USE THIS SOFTWARE
 */
import{C as e,D as t,H as n,T as r,W as i,at as a,b as o,it as s,j as c,u as l}from"./Spinner.js";import{O as u,T as d,d as f,f as p,p as m,v as h,y as g}from"./app.js";var _=c({__name:`AssetGallery`,props:{assetIds:{},page:{},active:{type:Boolean},sample:{type:Boolean},context:{}},setup(c){let _=c,v=m(),{thumbSize:y,thumbFit:b,viewportWidth:x,contentWidth:S}=l(v),C=d(),w=e(()=>_.active&&!C.isOpen),T=e(()=>g({viewportWidth:x.value,contentWidth:S.value,padding:h[_.page],minTileWidth:p(y.value)})),E=e(()=>[`gallery`,_.sample===!0?`sample`:`leaf`,y.value]);return(e,l)=>(n(),t(`div`,{class:a(E.value)},[(n(!0),t(o,null,i(c.assetIds,e=>(n(),r(f,{key:s(b)+`:`+s(u)(e),id:e,lazy:!0,active:w.value,context:c.context,"tile-width":T.value.tileWidth,sizes:T.value.sizes},null,8,[`id`,`active`,`context`,`tile-width`,`sizes`]))),128))],2))}});export{_ as t};