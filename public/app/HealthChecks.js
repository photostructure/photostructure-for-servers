/**
 * Copyright © 2026, PhotoStructure Inc. All rights reserved.
 *
 * BY USING THIS SOFTWARE, YOU ACCEPT ALL OF THE TERMS IN
 * https://photostructure.com/eula
 * IF YOU DO NOT ACCEPT THESE TERMS, DO NOT USE THIS SOFTWARE
 */
import{N as l,c as s}from"./Array.js";import{a}from"./Lazy.js";a("loading","welcome","ready","failed");const r=a("Summary","Library","System","Tools"),o={Summary:"bookmark-tabs",Library:"library",System:"computer",Tools:"wrench"},n=a("error","no-library","pending","stop-sync","warn","ok","disabled","installing"),t=[n.ok,n.disabled,n.pending,n.installing,n["no-library"]];function d(e){return!t.includes(e)}const i={pending:"busy-dots",installing:"busy-dots","no-library":"new-yellow",ok:"green-check",warn:"warning","stop-sync":"pause",error:"error",disabled:"sleeping-face-desat"};function u(e){return i[e]}const y={pending:"Health checks are running...",installing:"Installing photo and video tools…","no-library":"No library is open",ok:"OK",warn:"Warning","stop-sync":"Some health checks are preventing sync from running",error:"Some health checks failed: sync will not run",disabled:"Some health checks are disabled"};function k(e){return l(e)&&!s(e.id)&&!s(e.section)&&n.has(e.level)&&!s(e.msg)}const c={id:"summary",section:r.Summary};function g(){return r.values.map(e=>({section:e,emoji:o[e],results:e==="Summary"?[{...c,level:"pending",settled:!1,ts:Date.now(),msg:["⌚ Requesting health check results..."]}]:[]}))}export{y as H,u as h,k as i,d as l,g as n};
