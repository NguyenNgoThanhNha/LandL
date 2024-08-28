import { processState } from '@/contants/processState.ts'
import ProcessState from '@/components/molecules/ProcessState.tsx'

const ProcessHeader = () => {
  return (
    <div className={"grid md:grid-cols-7 bg-slate-50 mx-14 rounded p-2 sm:grid-cols-1 my-4"}>
      {
        processState.map((state, index)=> (
          <ProcessState status={state.status} title={state.title} key={index} id={state.id}/>
        ))
      }
    </div>
  )
}

export default ProcessHeader