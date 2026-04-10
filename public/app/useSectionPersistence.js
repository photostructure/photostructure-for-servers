/**
 * Copyright © 2026, PhotoStructure Inc. All rights reserved.
 *
 * BY USING THIS SOFTWARE, YOU ACCEPT ALL OF THE TERMS IN
 * https://photostructure.com/eula
 * IF YOU DO NOT ACCEPT THESE TERMS, DO NOT USE THIS SOFTWARE
 */
import{c as u}from"./Array.js";import{f,b as i,w as l}from"./toast.js";import{l as d}from"./platform.js";import{g as b}from"./SSEClient.js";function g(e){const o=atob(e),t=Uint8Array.from(o,r=>r.charCodeAt(0));return new TextDecoder().decode(t)}function h(e){try{return u(e)?void 0:JSON.parse(g(e))}catch{return}}function w(e){const o=new TextEncoder().encode(e);let t="";for(const r of o)t+=String.fromCharCode(r);return btoa(t)}let s;function C(){return s==null||s.getStatus()==="disconnected"}const S=d(()=>{window.addEventListener("beforeunload",()=>{s?.unsubscribe("progress")})}),O=f("progress",()=>{const e=i(!0),o=i([]),t=i([]);function r(c){o.value=c?.states??[],c?.rootTags!=null&&(t.value=c.rootTags)}function n(){S(),e.value=!1,s=b(),s.subscribe("progress"),s.on("progress",r)}function a(){e.value=!0,s!=null&&(s.off("progress",r),s.unsubscribe("progress"))}return{paused:e,states:o,rootTags:t,resumeSSE:n,pauseSSE:a}});function E(e,o){try{const t=localStorage.getItem(e);if(t!=null){const r=JSON.parse(t);for(const[n,a]of Object.entries(r))n in o&&typeof a=="boolean"&&(o[n].value=a)}}catch{}for(const t of Object.values(o))l(t,()=>{p(e,o)})}function p(e,o){const t={};for(const[r,n]of Object.entries(o))t[r]=n.value;try{localStorage.setItem(e,JSON.stringify(t))}catch{}}export{E as a,w as b,h as d,C as e,O as u};
