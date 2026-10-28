/**
 * Copyright © 2026, PhotoStructure Inc. All rights reserved.
 *
 * BY USING THIS SOFTWARE, YOU ACCEPT ALL OF THE TERMS IN
 * https://photostructure.com/eula
 * IF YOU DO NOT ACCEPT THESE TERMS, DO NOT USE THIS SOFTWARE
 */
import{G as e,Ot as t,U as n,V as r,Z as i,ft as a,j as o,kt as s,q as c,ut as l}from"./Spinner.js";import{M as u,a as d,i as f,m as p,o as m,p as h,v as g}from"./NavMenuButton.js";var _=i({__name:`AssetGallery`,props:{assetIds:{},page:{},active:{type:Boolean},sample:{type:Boolean},context:{},returnTo:{}},setup(i){let _=i,v=m(),{thumbSize:y,thumbFit:b,viewportWidth:x,contentWidth:S}=o(v),C=g(),w=n(()=>_.active&&!C.isOpen),T=n(()=>p({viewportWidth:x.value,contentWidth:S.value,padding:h[_.page],minTileWidth:d(y.value)})),E=n(()=>[`gallery`,_.sample===!0?`sample`:`leaf`,y.value]);return(n,o)=>(l(),c(`div`,{class:s(E.value)},[(l(!0),c(r,null,a(i.assetIds,n=>(l(),e(f,{key:t(b)+`:`+t(u)(n),id:n,lazy:!0,active:w.value,context:i.context,"return-to":i.returnTo,"tile-width":T.value.tileWidth,sizes:T.value.sizes},null,8,[`id`,`active`,`context`,`return-to`,`tile-width`,`sizes`]))),128))],2))}});export{_ as t};