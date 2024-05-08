"use strict";(self.webpackChunkdocusaurus=self.webpackChunkdocusaurus||[]).push([[621],{5680:(e,t,a)=>{a.d(t,{xA:()=>u,yg:()=>d});var i=a(6540);function r(e,t,a){return t in e?Object.defineProperty(e,t,{value:a,enumerable:!0,configurable:!0,writable:!0}):e[t]=a,e}function n(e,t){var a=Object.keys(e);if(Object.getOwnPropertySymbols){var i=Object.getOwnPropertySymbols(e);t&&(i=i.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),a.push.apply(a,i)}return a}function o(e){for(var t=1;t<arguments.length;t++){var a=null!=arguments[t]?arguments[t]:{};t%2?n(Object(a),!0).forEach((function(t){r(e,t,a[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(a)):n(Object(a)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(a,t))}))}return e}function l(e,t){if(null==e)return{};var a,i,r=function(e,t){if(null==e)return{};var a,i,r={},n=Object.keys(e);for(i=0;i<n.length;i++)a=n[i],t.indexOf(a)>=0||(r[a]=e[a]);return r}(e,t);if(Object.getOwnPropertySymbols){var n=Object.getOwnPropertySymbols(e);for(i=0;i<n.length;i++)a=n[i],t.indexOf(a)>=0||Object.prototype.propertyIsEnumerable.call(e,a)&&(r[a]=e[a])}return r}var s=i.createContext({}),p=function(e){var t=i.useContext(s),a=t;return e&&(a="function"==typeof e?e(t):o(o({},t),e)),a},u=function(e){var t=p(e.components);return i.createElement(s.Provider,{value:t},e.children)},c="mdxType",m={inlineCode:"code",wrapper:function(e){var t=e.children;return i.createElement(i.Fragment,{},t)}},g=i.forwardRef((function(e,t){var a=e.components,r=e.mdxType,n=e.originalType,s=e.parentName,u=l(e,["components","mdxType","originalType","parentName"]),c=p(a),g=r,d=c["".concat(s,".").concat(g)]||c[g]||m[g]||n;return a?i.createElement(d,o(o({ref:t},u),{},{components:a})):i.createElement(d,o({ref:t},u))}));function d(e,t){var a=arguments,r=t&&t.mdxType;if("string"==typeof e||r){var n=a.length,o=new Array(n);o[0]=g;var l={};for(var s in t)hasOwnProperty.call(t,s)&&(l[s]=t[s]);l.originalType=e,l[c]="string"==typeof e?e:r,o[1]=l;for(var p=2;p<n;p++)o[p]=a[p];return i.createElement.apply(null,o)}return i.createElement.apply(null,a)}g.displayName="MDXCreateElement"},8222:(e,t,a)=>{a.r(t),a.d(t,{assets:()=>s,contentTitle:()=>o,default:()=>m,frontMatter:()=>n,metadata:()=>l,toc:()=>p});var i=a(8168),r=(a(6540),a(5680));a(1873);const n={},o="Multi GPU with ICICLE",l={unversionedId:"icicle/multi-gpu",id:"icicle/multi-gpu",title:"Multi GPU with ICICLE",description:"If you are looking for the Multi GPU API documentation refer here for Rust and here for Golang.",source:"@site/docs/icicle/multi-gpu.md",sourceDirName:"icicle",slug:"/icicle/multi-gpu",permalink:"/icicle/multi-gpu",editUrl:"https://github.com/ingonyama-zk/icicle/tree/main/docs/icicle/multi-gpu.md",tags:[],version:"current",lastUpdatedBy:"nonam3e",lastUpdatedAt:1715199539,formattedLastUpdatedAt:"5/8/2024",frontMatter:{},sidebar:"GettingStartedSidebar",previous:{title:"Polynomial API Overview",permalink:"/icicle/polynomials/overview"},next:{title:"Golang bindings",permalink:"/icicle/golang-bindings"}},s={},p=[{value:"Approaches to Multi GPU programming",id:"approaches-to-multi-gpu-programming",level:2},{value:"GPU Server approach",id:"gpu-server-approach",level:3},{value:"Inter GPU approach",id:"inter-gpu-approach",level:3},{value:"Writing ICICLE Code for Multi GPUs",id:"writing-icicle-code-for-multi-gpus",level:2},{value:"Best practices",id:"best-practices",level:2},{value:"ZKContainer support for multi GPUs",id:"zkcontainer-support-for-multi-gpus",level:2}],u={toc:p},c="wrapper";function m(e){let{components:t,...n}=e;return(0,r.yg)(c,(0,i.A)({},u,n,{components:t,mdxType:"MDXLayout"}),(0,r.yg)("h1",{id:"multi-gpu-with-icicle"},"Multi GPU with ICICLE"),(0,r.yg)("div",{className:"admonition admonition-info alert alert--info"},(0,r.yg)("div",{parentName:"div",className:"admonition-heading"},(0,r.yg)("h5",{parentName:"div"},(0,r.yg)("span",{parentName:"h5",className:"admonition-icon"},(0,r.yg)("svg",{parentName:"span",xmlns:"http://www.w3.org/2000/svg",width:"14",height:"16",viewBox:"0 0 14 16"},(0,r.yg)("path",{parentName:"svg",fillRule:"evenodd",d:"M7 2.3c3.14 0 5.7 2.56 5.7 5.7s-2.56 5.7-5.7 5.7A5.71 5.71 0 0 1 1.3 8c0-3.14 2.56-5.7 5.7-5.7zM7 1C3.14 1 0 4.14 0 8s3.14 7 7 7 7-3.14 7-7-3.14-7-7-7zm1 3H6v5h2V4zm0 6H6v2h2v-2z"}))),"info")),(0,r.yg)("div",{parentName:"div",className:"admonition-content"},(0,r.yg)("p",{parentName:"div"},"If you are looking for the Multi GPU API documentation refer ",(0,r.yg)("a",{parentName:"p",href:"/icicle/rust-bindings/multi-gpu"},"here")," for Rust and ",(0,r.yg)("a",{parentName:"p",href:"/icicle/golang-bindings/multi-gpu"},"here")," for Golang."))),(0,r.yg)("p",null,"One common challenge with Zero-Knowledge computation is managing the large input sizes. It's not uncommon to encounter circuits surpassing 2^25 constraints, pushing the capabilities of even advanced GPUs to their limits. To effectively scale and process such large circuits, leveraging multiple GPUs in tandem becomes a necessity."),(0,r.yg)("p",null,"Multi-GPU programming involves developing software to operate across multiple GPU devices. Lets first explore different approaches to Multi-GPU programming then we will cover how ICICLE allows you to easily develop youR ZK computations to run across many GPUs."),(0,r.yg)("h2",{id:"approaches-to-multi-gpu-programming"},"Approaches to Multi GPU programming"),(0,r.yg)("p",null,"There are many ",(0,r.yg)("a",{parentName:"p",href:"https://github.com/NVIDIA/multi-gpu-programming-models"},"different strategies")," available for implementing multi GPU, however, it can be split into two categories."),(0,r.yg)("h3",{id:"gpu-server-approach"},"GPU Server approach"),(0,r.yg)("p",null,"This approach usually involves a single or multiple CPUs opening threads to read / write from multiple GPUs. You can think about it as a scaled up HOST - Device model."),(0,r.yg)("p",null,(0,r.yg)("img",{alt:"alt text",src:a(4094).A,width:"600",height:"552"})),(0,r.yg)("p",null,"This approach won't let us tackle larger computation sizes but it will allow us to compute multiple computations which we wouldn't be able to load onto a single GPU."),(0,r.yg)("p",null,"For example let's say that you had to compute two MSMs of size 2^26 on a 16GB VRAM GPU you would normally have to perform them asynchronously. However, if you double the number of GPUs in your system you can now run them in parallel."),(0,r.yg)("h3",{id:"inter-gpu-approach"},"Inter GPU approach"),(0,r.yg)("p",null,"This approach involves a more sophisticated approach to multi GPU computation. Using technologies such as ",(0,r.yg)("a",{parentName:"p",href:"https://www.nvidia.com/en-us/on-demand/session/gtcspring21-cwes1084/"},"GPUDirect, NCCL, NVSHMEM")," and NVLink it's possible to combine multiple GPUs and split a computation among different devices."),(0,r.yg)("p",null,"This approach requires redesigning the algorithm at the software level to be compatible with splitting amongst devices. In some cases, to lower latency to a minimum, special inter GPU connections would be installed on a server to allow direct communication between multiple GPUs."),(0,r.yg)("h2",{id:"writing-icicle-code-for-multi-gpus"},"Writing ICICLE Code for Multi GPUs"),(0,r.yg)("p",null,"The approach we have taken for the moment is a GPU Server approach; we assume you have a machine with multiple GPUs and you wish to run some computation on each GPU."),(0,r.yg)("p",null,"To dive deeper and learn about the API check out the docs for our different ICICLE API"),(0,r.yg)("ul",null,(0,r.yg)("li",{parentName:"ul"},(0,r.yg)("a",{parentName:"li",href:"/icicle/rust-bindings/multi-gpu"},"Rust Multi GPU APIs")),(0,r.yg)("li",{parentName:"ul"},(0,r.yg)("a",{parentName:"li",href:"/icicle/golang-bindings/multi-gpu"},"Golang Multi GPU APIs")),(0,r.yg)("li",{parentName:"ul"},"C++ Multi GPU APIs")),(0,r.yg)("h2",{id:"best-practices"},"Best practices"),(0,r.yg)("ul",null,(0,r.yg)("li",{parentName:"ul"},(0,r.yg)("p",{parentName:"li"},"Never hardcode device IDs, if you want your software to take advantage of all GPUs on a machine use methods such as ",(0,r.yg)("inlineCode",{parentName:"p"},"get_device_count")," to support arbitrary number of GPUs.")),(0,r.yg)("li",{parentName:"ul"},(0,r.yg)("p",{parentName:"li"},"Launch one CPU thread per GPU. To avoid ",(0,r.yg)("a",{parentName:"p",href:"https://developer.nvidia.com/blog/cuda-pro-tip-always-set-current-device-avoid-multithreading-bugs/"},"nasty errors")," and hard to read code we suggest that for every GPU you create a dedicated thread. Within a CPU thread you should be able to launch as many tasks as you wish for a GPU as long as they all run on the same GPU id. This will make your code way more manageable, easy to read and performant."))),(0,r.yg)("h2",{id:"zkcontainer-support-for-multi-gpus"},"ZKContainer support for multi GPUs"),(0,r.yg)("p",null,"Multi GPU support should work with ZK-Containers by simply defining which devices the docker container should interact with:"),(0,r.yg)("pre",null,(0,r.yg)("code",{parentName:"pre",className:"language-sh"},"docker run -it --gpus '\"device=0,2\"' zk-container-image\n")),(0,r.yg)("p",null,"If you wish to expose all GPUs"),(0,r.yg)("pre",null,(0,r.yg)("code",{parentName:"pre",className:"language-sh"},"docker run --gpus all zk-container-image\n")))}m.isMDXComponent=!0},4094:(e,t,a)=>{a.d(t,{A:()=>i});const i=a.p+"assets/images/image-18256543a80eeb7c54cd4680b5ee5ddb.png"},1873:(e,t,a)=>{a(6540)}}]);