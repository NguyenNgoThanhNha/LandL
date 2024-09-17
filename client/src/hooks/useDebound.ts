import { useEffect, useState } from 'react';

function useDebounce(input: string, delay: number = 500): string {
  const [debouncedValue, setDebouncedValue] = useState<string>(input);
  
  useEffect(() => {
    const timer = setTimeout(() => {
      setDebouncedValue(input);
    }, delay);
    
    return () => {
      clearTimeout(timer);
    };
  }, [input, delay]);
  
  return debouncedValue;
}

export default useDebounce;