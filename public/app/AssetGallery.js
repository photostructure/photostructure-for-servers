/**
 * Copyright © 2026, PhotoStructure Inc. All rights reserved.
 *
 * BY USING THIS SOFTWARE, YOU ACCEPT ALL OF THE TERMS IN
 * https://photostructure.com/eula
 * IF YOU DO NOT ACCEPT THESE TERMS, DO NOT USE THIS SOFTWARE
 */
import{D as e,F as t,Y as n,dt as r,ft as i,j as a,k as o,m as s,q as c,w as l}from"./Spinner.js";import{M as u,a as d,i as f,m as p,o as m,p as h,v as g}from"./NavMenuButton.js";var _=t({__name:`AssetGallery`,props:{assetIds:{},page:{},active:{type:Boolean},sample:{type:Boolean},context:{},returnTo:{}},setup(t){let _=t,v=m(),{thumbSize:y,thumbFit:b,viewportWidth:x,contentWidth:S}=s(v),C=g(),w=e(()=>_.active&&!C.isOpen),T=e(()=>p({viewportWidth:x.value,contentWidth:S.value,padding:h[_.page],minTileWidth:d(y.value)})),E=e(()=>[`gallery`,_.sample===!0?`sample`:`leaf`,y.value]);return(e,s)=>(c(),a(`div`,{class:i(E.value)},[(c(!0),a(l,null,n(t.assetIds,e=>(c(),o(f,{key:r(b)+`:`+r(u)(e),id:e,lazy:!0,active:w.value,context:t.context,"return-to":t.returnTo,"tile-width":T.value.tileWidth,sizes:T.value.sizes},null,8,[`id`,`active`,`context`,`return-to`,`tile-width`,`sizes`]))),128))],2))}});export{_ as t};