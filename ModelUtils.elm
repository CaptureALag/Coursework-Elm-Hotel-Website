module ModelUtils exposing(..)

import Models exposing(..)

getHotelsOnCurrentPage : Model -> List Hotel
getHotelsOnCurrentPage model =
   List.take 4
    (((   case model.appState.currentSortOption of
             Popularity -> List.sortBy (.popularity)
             Stars -> List.sortBy (.stars)
             Price -> List.sortBy (.popularity)
     ) >> case model.appState.currentSortOrder of
             Asc -> identity
             Desc -> List.reverse
     )  
        model.appContent.hotels)

sortingOptionLabel : SortOption -> String
sortingOptionLabel opt =
   case opt of
      Popularity -> "Популярністю"
      Stars -> "Кількістю зірок"
      Price -> "Ціною"

sortingOrderLabel : SortOrder -> String
sortingOrderLabel ord =
   case ord of
      Asc -> "▲"
      Desc -> "▼"

negateSortOrder : SortOrder -> SortOrder
negateSortOrder ord =
   case ord of
      Asc -> Desc
      Desc -> Asc
