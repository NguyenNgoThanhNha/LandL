export const formatCurrency = (amount: number): string => {
  const formatter = new Intl.NumberFormat('vi-VN', {
    style: 'decimal',
    maximumFractionDigits: 0,
    minimumFractionDigits: 0
  })
  return `${formatter.format(amount)} VND`
}
