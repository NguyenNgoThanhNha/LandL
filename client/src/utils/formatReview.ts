export const formatReview = (ratingValue: number): string => {
  if (ratingValue <= 1) {
    return 'Very Bad'
  } else if (ratingValue > 1 && ratingValue <= 2) {
    return 'Bad'
  } else if (ratingValue > 2 && ratingValue <= 3) {
    return 'Average'
  } else if (ratingValue > 3 && ratingValue <= 4) {
    return 'Good'
  } else if (ratingValue > 4 && ratingValue < 5) {
    return 'Excellent'
  } else if (ratingValue === 5) {
    return 'Amazing'
  } else {
    return 'Rating out of range'
  }
}
