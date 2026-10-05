import {adviseCore} from './adviser-core';
import {all,stmt,runtime} from './repository';
export async function advise(question:string,conversation:any[],snapshot:any,user:any,requestId:string){return adviseCore(question,conversation,snapshot,user,requestId,{all,stmt,runtime,fetch});}
