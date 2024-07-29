import { Accordion } from '@/components/atoms/ui/accordion.tsx'
import { FREQUENT_ASKED_QUESTIONS } from '@/contants/frequentAskedQuestion.ts'
import AccordionLine from '@/components/molecules/AccordionLine.tsx'
import { Badge } from '@/components/atoms/ui/badge.tsx'

const FrequentAskedQuestion = () => {
  return (
    <div className={'flex flex-col gap-6'}>
      <div className={'flex flex-col gap-4'}>
        <Badge className={'w-fit rounded bg-orangeTheme'}>FAQ</Badge>
        <div className={'font-bold text-4xl'}>
          FREQUENTLY ASKED <br /> QUESTIONS
        </div>
      </div>
      <Accordion type={'single'} collapsible className={'w-[500px] rounded'}>
        {FREQUENT_ASKED_QUESTIONS.map((question) => (
          <AccordionLine id={question.id} title={question.title} content={question.content} key={question.id} />
        ))}
      </Accordion>
    </div>
  )
}

export default FrequentAskedQuestion
