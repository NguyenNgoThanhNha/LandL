const AboutUsLine = () => {
  return (
    <div
      className={
        'bg-[url(/home-3.png)] w-full h-[500px] bg-cover grid md:grid-cols-2 sm:grid-cols-1 text-white items-center'
      }
    >
      <div className={' col-span-1 flex justify-center'}>
        <div className={'relative bg-orangeTheme w-fit p-2 transform -translate-y-24'}>
          <img src={'/home-4.png'} className={'object-cover w-72 '} alt={'home-4.png'} />
          <div
            className={
              ' absolute z-10 uppercase right-0 bottom-14 text-4xl bg-orangeTheme text-white font-semibold w-60 tracking-tighter p-4 transform translate-x-28'
            }
          >
            Best in the business
          </div>
        </div>
      </div>
      <div className={'col-span-1'}>
        <p className={'font-semibold text-4xl uppercase mb-6'}>About us</p>
        <p className={'md:w-3/4 sm:w-full md:px-0 sm:px-5'}>
          The same is true for companies. In addition to the information above, people who find your company online want
          to know about your mission, vision, and how you can help them solve their problems.The same is true for
          companies. In addition to the information above, people who find your company online want to know about your
          mission, vision, and how you can help them solve their problems.
        </p>
      </div>
    </div>
  )
}

export default AboutUsLine
