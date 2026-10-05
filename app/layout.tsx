import type {Metadata} from 'next';
import './globals.css';
export const metadata:Metadata={title:'Datacenter Design Explorer',description:'Evidence, engineering and ten-year scenario comparison for shared university AI infrastructure'};
export default function Layout({children}:{children:React.ReactNode}){return <html lang="en"><body>{children}</body></html>}
