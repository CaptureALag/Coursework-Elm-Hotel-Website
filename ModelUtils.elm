module ModelUtils exposing(..)

import Models exposing(..)

getHotelsOnCurrentPage : Model -> List Hotel
getHotelsOnCurrentPage model =
   List.take 4 model.appContent.hotels

sortingOptionLabel : SortOption -> String
sortingOptionLabel opt =
   case opt of
      Popularity -> "Популярністю"
      Stars -> "Кількістю зірок"
      Price -> "Ціною"
