/**
 * Copyright © 2026, PhotoStructure Inc. All rights reserved.
 *
 * BY USING THIS SOFTWARE, YOU ACCEPT ALL OF THE TERMS IN
 * https://photostructure.com/eula
 * IF YOU DO NOT ACCEPT THESE TERMS, DO NOT USE THIS SOFTWARE
 */
import{c as i}from"./Array.js";import{f as u,b as f,w as l}from"./toast.js";import{g as d}from"./DropDown.vue_vue_type_script_setup_true_lang.js";function S(t){const o=atob(t),e=Uint8Array.from(o,r=>r.charCodeAt(0));return new TextDecoder().decode(e)}function y(t){try{return i(t)?void 0:JSON.parse(S(t))}catch{return}}function v(t){const o=new TextEncoder().encode(t);let e="";for(const r of o)e+=String.fromCharCode(r);return btoa(e)}let s;function T(){return s==null||s.getStatus()==="disconnected"}const h=u("progress",()=>{const t=f(!0),o=f([]),e=f([]);function r(c){o.value=c?.states??[],c?.rootTags!=null&&(e.value=c.rootTags)}function n(){t.value=!1,s=d(),s.on("progress",r)}function a(){t.value=!0,s?.off("progress",r)}return{paused:t,states:o,rootTags:e,resumeSSE:n,pauseSSE:a}});function C(t,o){try{const e=localStorage.getItem(t);if(e!=null){const r=JSON.parse(e);for(const[n,a]of Object.entries(r))n in o&&typeof a=="boolean"&&(o[n].value=a)}}catch{}for(const e of Object.values(o))l(e,()=>{b(t,o)})}function b(t,o){const e={};for(const[r,n]of Object.entries(o))e[r]=n.value;try{localStorage.setItem(t,JSON.stringify(e))}catch{}}export{C as a,v as b,y as d,T as e,h as u};
