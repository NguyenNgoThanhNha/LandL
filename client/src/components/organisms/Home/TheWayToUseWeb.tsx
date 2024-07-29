import { STEPS_USE_WEB } from '@/contants/stepUseWeb.ts'
import { cn } from '@/utils/cn.ts'

const TheWayToUseWeb = () => {
  return (
    <div className={"flex flex-col items-center gap-y-6 py-6 w-full h-fit bg-cover bg-[url('/home-2.png')]"}>
      <p className={'uppercase text-4xl font-bold text-orangeTheme text-center'}>How to use our service? </p>
      <div className={'flex flex-col gap-y-2 justify-center md:w-1/3 sm:w-3/4 '}>
        {STEPS_USE_WEB.map((step) => (
          <div
            key={step.id}
            className={cn(
              'flex flex-col gap-1 px-4 py-3 rounded  ',
              step.id % 2 !== 0 ? 'bg-darkTheme text-white' : 'text-black bg-slate-100'
            )}
          >
            <p className={'font-semibold'}>Step {step.id}</p>
            <p>{step.content}</p>
          </div>
        ))}
      </div>
    </div>
  )
}

export default TheWayToUseWeb
