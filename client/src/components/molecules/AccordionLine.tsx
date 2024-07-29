import { AccordionContent, AccordionItem, AccordionTrigger } from '@/components/atoms/ui/accordion.tsx'

interface AccordionLineProps {
  id: number
  title: string
  content: string
}
const AccordionLine = ({ id, title, content }: AccordionLineProps) => {
  return (
    <AccordionItem value={id.toString()} className={' items-center space-x-2 w-full'}>
      <AccordionTrigger className={'px-2 py-4 decoration-transparent'}>{title}</AccordionTrigger>
      <AccordionContent className={'p-2'}>
        <p className={'font-black'}>Answer:</p>
        <p>{content}</p>
      </AccordionContent>
    </AccordionItem>
  )
}

export default AccordionLine
