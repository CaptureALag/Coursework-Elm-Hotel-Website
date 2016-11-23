import Html exposing (Html, node, div, button, text, nav, a)
import Html.Attributes exposing (class, classList, href, rel)
import Html.App exposing (beginnerProgram)
import Html.Events exposing (onClick)
import Dict exposing (Dict)
import ContentLayout exposing (renderLayout)
import Models exposing (..)
import Regex exposing (..)

import Debug

main =
  beginnerProgram { model = 
    { appState =
        { selectedNavIcon = 
            "icon-navigation"

        , currentRoute = MenuPage

        , currentSortOption = Popularity
        , currentSortOrder = Desc
        , currentPage = 1
        , currentFilterByCountry = Nothing

        , formSubmitted = False
        , formPhone = ""
        , formFailureMessage = ""

        , selectedBlogEntryId = Nothing
        }
    , appContent =         
        { countries = 
            [ { id = "cyprus"
              , name = "Кіпр"
              , nameLocativeCase = "Кіпр" 
              },
              { id = "ibiza"
              , name = "Ібіца"
              , nameLocativeCase = "Ібіцу" 
              },
              { id = "malta"
              , name = "Мальта"
              , nameLocativeCase = "Мальту" 
              },
              { id = "crit"
              , name = "Крит"
              , nameLocativeCase = "Крит" 
              }
            ]
        , blog = 
            [ { id = 1
              , timePosted = "12.08"
              , header = "На території готеля Cassandra Mare відкрився новий ресторан \"MARE A NORI\" "
              , fullText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse orci erat, porttitor vel fringilla ut, lobortis vitae risus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec ac dui odio. Donec a finibus purus. Nullam quis lacus vitae leo commodo placerat id ac lorem. Ut eleifend urna quis mattis volutpat."
              },
              { id = 2
              , timePosted = "10.08"
              , header = "Nulla facilisi. Nam maximus nisi eget egestas bibendum. Pellentesque in molestie libero."
              , fullText = "Nam placerat massa et tempor feugiat. Curabitur suscipit tellus sodales elit vulputate, ut tincidunt ligula ullamcorper. Pellentesque suscipit bibendum sem at pellentesque. Nam tristique purus ligula, id volutpat lectus porta in. Duis tortor sem, egestas non pellentesque quis, bibendum sit amet odio. Vestibulum vitae euismod tortor."
              },
              { id = 3
              , timePosted = "09.08"
              , header = "Aliquam fringilla sapien vitae orci malesuada, id eleifend ante semper."
              , fullText = "Nullam tempor ullamcorper erat. Sed bibendum lectus ut purus efficitur, eu posuere lectus eleifend. Sed fringilla felis in cursus egestas. Quisque gravida eleifend lacus ut pulvinar. Ut viverra arcu vel elementum volutpat. Phasellus pharetra dolor id dignissim auctor. Nunc ut luctus diam. Ut convallis lacinia metus quis fringilla. Quisque eget erat felis."
              },
              { id = 4
              , timePosted = "07.08"
              , header = "Quisque non odio fermentum, eleifend mi vitae, imperdiet enim. Duis elementum sed orci eu aliquam."
              , fullText = " Donec et pharetra erat. Sed in metus id augue feugiat bibendum sit amet vitae augue. Integer semper orci diam. Praesent luctus molestie erat vitae rutrum. Duis felis leo, suscipit in orci eget, feugiat faucibus nisi. Vestibulum maximus, eros id feugiat ornare, velit urna gravida justo, et iaculis elit eros a elit."        
              }{-,
              { id = 5
              , timePosted = "06.08"
              , header = "На території готеля Cassandra Mare відкрився новий ресторан \"MARE A NORI\" "
              , fullText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse orci erat, porttitor vel fringilla ut, lobortis vitae risus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec ac dui odio. Donec a finibus purus. Nullam quis lacus vitae leo commodo placerat id ac lorem. Ut eleifend urna quis mattis volutpat. Donec malesuada purus eget arcu porta, in rutrum nisl pulvinar. Aenean finibus, massa vel bibendum efficitur, libero lacus pretium mauris, at sollicitudin enim neque a arcu. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas."
              },
              { id = 6
              , timePosted = "04.08"
              , header = "Nulla facilisi. Nam maximus nisi eget egestas bibendum. Pellentesque in molestie libero."
              , fullText = "Nam placerat massa et tempor feugiat. Curabitur suscipit tellus sodales elit vulputate, ut tincidunt ligula ullamcorper. Pellentesque suscipit bibendum sem at pellentesque. Nam tristique purus ligula, id volutpat lectus porta in. Duis tortor sem, egestas non pellentesque quis, bibendum sit amet odio. Vestibulum vitae euismod tortor. Quisque ex ante, fermentum eget efficitur sed, pharetra id nunc. Vivamus gravida massa dolor, at tempus justo molestie eu. Nulla in ultricies mi. Suspendisse auctor turpis dapibus quam porta, sit amet convallis sem finibus. Quisque sit amet eros commodo, fermentum arcu eu, congue lectus. Vivamus aliquam malesuada ultrices. Aliquam erat volutpat.
              
              Donec sed nisi feugiat, fringilla diam tempor, aliquam lorem. Cras maximus ultricies purus quis tristique. Etiam venenatis facilisis nunc, mattis elementum tortor lobortis eu. Integer a congue felis, et lobortis lorem. Vestibulum interdum finibus mauris et lobortis. Nullam non leo commodo, bibendum erat sit amet, accumsan odio. Morbi sit amet nunc vitae lacus vulputate fringilla sed quis est. Pellentesque magna ipsum, ultrices in pulvinar nec, varius tempor eros. Nunc fermentum dolor sit amet congue euismod. Donec fringilla neque nulla, vel consectetur ex bibendum at. Maecenas fermentum congue velit, eget luctus purus. Morbi ullamcorper ultricies nulla vitae tincidunt. Morbi purus nisl, suscipit vel mollis vitae, cursus ut justo. Mauris nec felis orci. Ut nec luctus erat. "
              },
              { id = 7
              , timePosted = "03.08"
              , header = "Aliquam fringilla sapien vitae orci malesuada, id eleifend ante semper."
              , fullText = "Nullam tempor ullamcorper erat. Sed bibendum lectus ut purus efficitur, eu posuere lectus eleifend. Sed fringilla felis in cursus egestas. Quisque gravida eleifend lacus ut pulvinar. Ut viverra arcu vel elementum volutpat. Phasellus pharetra dolor id dignissim auctor. Nunc ut luctus diam. Ut convallis lacinia metus quis fringilla. Quisque eget erat felis. Aliquam finibus elit eros, et faucibus nisi placerat a. Nam ullamcorper nunc vulputate ante lobortis, at tincidunt ipsum ultricies. Vestibulum mattis sit amet justo et dictum. Vestibulum sit amet volutpat nunc, quis tincidunt tellus. Curabitur a velit ex. Ut et dolor ultrices, tincidunt orci ac, vehicula felis. "
              },
              { id = 8
              , timePosted = "01.08"
              , header = "Quisque non odio fermentum, eleifend mi vitae, imperdiet enim. Duis elementum sed orci eu aliquam."
              , fullText = " Donec et pharetra erat. Sed in metus id augue feugiat bibendum sit amet vitae augue. Integer semper orci diam. Praesent luctus molestie erat vitae rutrum. Duis felis leo, suscipit in orci eget, feugiat faucibus nisi. Vestibulum maximus, eros id feugiat ornare, velit urna gravida justo, et iaculis elit eros a elit. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum odio quam, aliquet sed magna sed, vulputate tincidunt sapien. Quisque nec ligula placerat, gravida quam eget, luctus sapien. Nulla ac risus pulvinar, pellentesque turpis nec, tempus sapien. "        
    }   -} 
            ]
        , hotels =
            [
              { id = "cassandra-mare"
              , name = "Cassandra Mare"
              , popularity = 1
              , countryId = "malta"
              , stars = 5
              , bgPhotoUrl = "bg_1.jpg"
              , photoUrls = []
              , priceOptions = 
                  [ 
                    { name = "OB"
                    , personCapacity = 1
                    , price = 400
                    },
                    { name = "BB"
                    , personCapacity = 1
                    , price = 550
                    },
                    { name = "OB"
                    , personCapacity = 2
                    , price = 600 
                    }, 
                    { name = "ALL"
                    , personCapacity = 2
                    , price = 1000
                    }
                  ]   
              , duration = 6
              , depart = "14.08.2017"

              , videoUrl = Just "https://www.youtube.com/embed/1tP2INzqnaQ"

              , description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras aliquet lobortis turpis, nec suscipit diam. Nulla facilisi. Nunc varius nunc sit amet metus faucibus iaculis. Maecenas faucibus condimentum urna, sit amet placerat velit blandit in. Sed tincidunt, est et porta tincidunt, purus augue porttitor velit, et egestas odio est a dui. Integer tincidunt consequat ante nec vehicula. Etiam vehicula diam ipsum, lobortis mattis odio dapibus ac. Nam elementum lobortis ligula, vel pharetra nunc rutrum eu. Duis commodo convallis elit elementum viverra. Nam dapibus ex quis auctor volutpat."

              , features = 
                  [ "Vivamus at felis quis massa hendrerit rutrum."      
                  , "Aliquam erat sem, congue et elementum in, pretium eu eros."
                  , "Suspendisse potenti. Quisque arcu ipsum, pulvinar quis pulvinar feugiat, aliquam ac turpis."
                  , "Fusce rhoncus massa lorem. Etiam feugiat magna aliquet arcu vehicula, vel laoreet enim tincidunt."
                  ]

              , postDescription = "In eget cursus leo. Sed a ex ex. Nam sit amet est iaculis, maximus magna eu, porta metus. Sed eu ex finibus, rhoncus lectus sit amet, facilisis eros. Pellentesque id ipsum rhoncus, pulvinar justo id, lobortis nisl. Curabitur porttitor mi nibh, sit amet iaculis neque iaculis bibendum. Praesent consectetur mi a magna dapibus, sed placerat lacus interdum. In egestas vel tellus eget tincidunt. Curabitur eros nisi, bibendum a lorem vitae, vehicula interdum ipsum. Sed quis egestas ex."
              },  
              { id = "akrathos-hotel"
              , name = "Akrathos Hotel"
              , popularity = 2
              , countryId = "ibiza"
              , stars = 4
              , bgPhotoUrl = "bg_2.jpg"
              , photoUrls = []
              , priceOptions = 
                  [ 
                    { name = "OB"
                    , personCapacity = 1
                    , price = 200
                    },
                    { name = "BB"
                    , personCapacity = 1
                    , price = 250
                    },
                    { name = "OB"
                    , personCapacity = 2
                    , price = 300 
                    }, 
                    { name = "ALL"
                    , personCapacity = 2
                    , price = 800
                    }
                  ]
              , duration = 5    
              , depart = "8.08.2017"

              , videoUrl = Nothing

              , description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras aliquet lobortis turpis, nec suscipit diam. Nulla facilisi. Nunc varius nunc sit amet metus faucibus iaculis. Maecenas faucibus condimentum urna, sit amet placerat velit blandit in. Sed tincidunt, est et porta tincidunt, purus augue porttitor velit, et egestas odio est a dui. Integer tincidunt consequat ante nec vehicula. Etiam vehicula diam ipsum, lobortis mattis odio dapibus ac. Nam elementum lobortis ligula, vel pharetra nunc rutrum eu. Duis commodo convallis elit elementum viverra. Nam dapibus ex quis auctor volutpat."

              , features = 
                  [ "Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus."      
                  , "Donec sit amet sem vulputate neque tempor elementum."
                  , "Maecenas congue, tortor ut fringilla interdum, erat metus accumsan ligula, at faucibus augue lorem sed ante."
                  , "Pellentesque pharetra luctus velit imperdiet lobortis. Praesent rutrum condimentum tempus."
                  ]

              , postDescription = "In eget cursus leo. Sed a ex ex. Nam sit amet est iaculis, maximus magna eu, porta metus. Sed eu ex finibus, rhoncus lectus sit amet, facilisis eros. Pellentesque id ipsum rhoncus, pulvinar justo id, lobortis nisl. Curabitur porttitor mi nibh, sit amet iaculis neque iaculis bibendum. Praesent consectetur mi a magna dapibus, sed placerat lacus interdum. In egestas vel tellus eget tincidunt. Curabitur eros nisi, bibendum a lorem vitae, vehicula interdum ipsum. Sed quis egestas ex."


              },
              { id = "alara-hotel"
              , name = "Alara Hotel"
              , popularity = 3
              , countryId = "cyprus"
              , stars = 3
              , bgPhotoUrl = "bg_3.jpg"
              , photoUrls = []
              , priceOptions = 
                  [ 
                    { name = "OB"
                    , personCapacity = 1
                    , price = 150
                    },
                    { name = "BB"
                    , personCapacity = 1
                    , price = 250
                    },
                    { name = "OB"
                    , personCapacity = 2
                    , price = 300 
                    }, 
                    { name = "ALL"
                    , personCapacity = 2
                    , price = 600
                    }
                  ]  
              , duration = 4
              , depart = "24.08.2017"

              , videoUrl = Nothing
 
              , description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras aliquet lobortis turpis, nec suscipit diam. Nulla facilisi. Nunc varius nunc sit amet metus faucibus iaculis. Maecenas faucibus condimentum urna, sit amet placerat velit blandit in. Sed tincidunt, est et porta tincidunt, purus augue porttitor velit, et egestas odio est a dui. Integer tincidunt consequat ante nec vehicula. Etiam vehicula diam ipsum, lobortis mattis odio dapibus ac. Nam elementum lobortis ligula, vel pharetra nunc rutrum eu. Duis commodo convallis elit elementum viverra. Nam dapibus ex quis auctor volutpat."

              , features = 
                  [ "Suspendisse volutpat at odio sed dignissim."      
                  , "Donec sit amet sem vulputate neque tempor elementum."
                  , "Sed nec lorem eu felis fringilla faucibus."
                  , "Pellentesque pharetra luctus velit imperdiet lobortis. Praesent rutrum condimentum tempus."
                  ]

              , postDescription = "In eget cursus leo. Sed a ex ex. Nam sit amet est iaculis, maximus magna eu, porta metus. Sed eu ex finibus, rhoncus lectus sit amet, facilisis eros. Pellentesque id ipsum rhoncus, pulvinar justo id, lobortis nisl. Curabitur porttitor mi nibh, sit amet iaculis neque iaculis bibendum. Praesent consectetur mi a magna dapibus, sed placerat lacus interdum. In egestas vel tellus eget tincidunt. Curabitur eros nisi, bibendum a lorem vitae, vehicula interdum ipsum. Sed quis egestas ex."



              },
              { id = "boumerang"
              , name = "Boumerang"
              , popularity = 4
              , countryId = "crit"
              , stars = 4
              , bgPhotoUrl = "bg_4.jpg"
              , photoUrls = []
              , priceOptions = 
                  [ 
                    { name = "OB"
                    , personCapacity = 1
                    , price = 200
                    },
                    { name = "BB"
                    , personCapacity = 1
                    , price = 250
                    },
                    { name = "OB"
                    , personCapacity = 2
                    , price = 300 
                    }, 
                    { name = "ALL"
                    , personCapacity = 2
                    , price = 800
                    }
                  ] 
            , duration = 5
            , depart = "21.08.2017"

            , videoUrl = Nothing

            , description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras aliquet lobortis turpis, nec suscipit diam. Nulla facilisi. Nunc varius nunc sit amet metus faucibus iaculis. Maecenas faucibus condimentum urna, sit amet placerat velit blandit in. Sed tincidunt, est et porta tincidunt, purus augue porttitor velit, et egestas odio est a dui. Integer tincidunt consequat ante nec vehicula. Etiam vehicula diam ipsum, lobortis mattis odio dapibus ac. Nam elementum lobortis ligula, vel pharetra nunc rutrum eu. Duis commodo convallis elit elementum viverra. Nam dapibus ex quis auctor volutpat."

            , features = 
                  [ "Suspendisse volutpat at odio sed dignissim."      
                  , "Donec sit amet sem vulputate neque tempor elementum."
                  , "Sed nec lorem eu felis fringilla faucibus."
                  , "Pellentesque pharetra luctus velit imperdiet lobortis. Praesent rutrum condimentum tempus."
                  ]

            , postDescription = "In eget cursus leo. Sed a ex ex. Nam sit amet est iaculis, maximus magna eu, porta metus. Sed eu ex finibus, rhoncus lectus sit amet, facilisis eros. Pellentesque id ipsum rhoncus, pulvinar justo id, lobortis nisl. Curabitur porttitor mi nibh, sit amet iaculis neque iaculis bibendum. Praesent consectetur mi a magna dapibus, sed placerat lacus interdum. In egestas vel tellus eget tincidunt. Curabitur eros nisi, bibendum a lorem vitae, vehicula interdum ipsum. Sed quis egestas ex."

            },
            { id = "sample-hotel-1"
              , name = "Sample Hotel 1"
              , popularity = -1
              , countryId = "malta"
              , stars = 3
              , bgPhotoUrl = "bg_1.jpg"
              , photoUrls = []
              , priceOptions = 
                  [ 
                    { name = "OB"
                    , personCapacity = 1
                    , price = 400
                    },
                    { name = "BB"
                    , personCapacity = 1
                    , price = 550
                    },
                    { name = "OB"
                    , personCapacity = 2
                    , price = 600 
                    }, 
                    { name = "ALL"
                    , personCapacity = 2
                    , price = 1000
                    }
                  ]   
              , duration = 6
              , depart = "11.08.2017"

              , videoUrl = Just "https://www.youtube.com/embed/1tP2INzqnaQ"

              , description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras aliquet lobortis turpis, nec suscipit diam. Nulla facilisi. Nunc varius nunc sit amet metus faucibus iaculis. Maecenas faucibus condimentum urna, sit amet placerat velit blandit in. Sed tincidunt, est et porta tincidunt, purus augue porttitor velit, et egestas odio est a dui. Integer tincidunt consequat ante nec vehicula. Etiam vehicula diam ipsum, lobortis mattis odio dapibus ac. Nam elementum lobortis ligula, vel pharetra nunc rutrum eu. Duis commodo convallis elit elementum viverra. Nam dapibus ex quis auctor volutpat."

              , features = 
                  [ "Vivamus at felis quis massa hendrerit rutrum."      
                  , "Aliquam erat sem, congue et elementum in, pretium eu eros."
                  , "Suspendisse potenti. Quisque arcu ipsum, pulvinar quis pulvinar feugiat, aliquam ac turpis."
                  , "Fusce rhoncus massa lorem. Etiam feugiat magna aliquet arcu vehicula, vel laoreet enim tincidunt."
                  ]

              , postDescription = "In eget cursus leo. Sed a ex ex. Nam sit amet est iaculis, maximus magna eu, porta metus. Sed eu ex finibus, rhoncus lectus sit amet, facilisis eros. Pellentesque id ipsum rhoncus, pulvinar justo id, lobortis nisl. Curabitur porttitor mi nibh, sit amet iaculis neque iaculis bibendum. Praesent consectetur mi a magna dapibus, sed placerat lacus interdum. In egestas vel tellus eget tincidunt. Curabitur eros nisi, bibendum a lorem vitae, vehicula interdum ipsum. Sed quis egestas ex."
              },  
              { id = "sample-0"
              , name = "Sample Hotel 0"
              , popularity = 0
              , countryId = "ibiza"
              , stars = 3
              , bgPhotoUrl = "bg_2.jpg"
              , photoUrls = []
              , priceOptions = 
                  [ 
                    { name = "OB"
                    , personCapacity = 1
                    , price = 200
                    },
                    { name = "BB"
                    , personCapacity = 1
                    , price = 250
                    },
                    { name = "OB"
                    , personCapacity = 2
                    , price = 300 
                    }, 
                    { name = "ALL"
                    , personCapacity = 2
                    , price = 800
                    }
                  ]
              , duration = 5    
              , depart = "8.08.2017"

              , videoUrl = Nothing

              , description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras aliquet lobortis turpis, nec suscipit diam. Nulla facilisi. Nunc varius nunc sit amet metus faucibus iaculis. Maecenas faucibus condimentum urna, sit amet placerat velit blandit in. Sed tincidunt, est et porta tincidunt, purus augue porttitor velit, et egestas odio est a dui. Integer tincidunt consequat ante nec vehicula. Etiam vehicula diam ipsum, lobortis mattis odio dapibus ac. Nam elementum lobortis ligula, vel pharetra nunc rutrum eu. Duis commodo convallis elit elementum viverra. Nam dapibus ex quis auctor volutpat."

              , features = 
                  [ "Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus."      
                  , "Donec sit amet sem vulputate neque tempor elementum."
                  , "Maecenas congue, tortor ut fringilla interdum, erat metus accumsan ligula, at faucibus augue lorem sed ante."
                  , "Pellentesque pharetra luctus velit imperdiet lobortis. Praesent rutrum condimentum tempus."
                  ]

              , postDescription = "In eget cursus leo. Sed a ex ex. Nam sit amet est iaculis, maximus magna eu, porta metus. Sed eu ex finibus, rhoncus lectus sit amet, facilisis eros. Pellentesque id ipsum rhoncus, pulvinar justo id, lobortis nisl. Curabitur porttitor mi nibh, sit amet iaculis neque iaculis bibendum. Praesent consectetur mi a magna dapibus, sed placerat lacus interdum. In egestas vel tellus eget tincidunt. Curabitur eros nisi, bibendum a lorem vitae, vehicula interdum ipsum. Sed quis egestas ex."


              },
              { id = "sample-hotel-2"
              , name = "Sample Hotel 2"
              , popularity = -2
              , countryId = "cyprus"
              , stars = 3
              , bgPhotoUrl = "bg_3.jpg"
              , photoUrls = []
              , priceOptions = 
                  [ 
                    { name = "OB"
                    , personCapacity = 1
                    , price = 150
                    },
                    { name = "BB"
                    , personCapacity = 1
                    , price = 250
                    },
                    { name = "OB"
                    , personCapacity = 2
                    , price = 300 
                    }, 
                    { name = "ALL"
                    , personCapacity = 2
                    , price = 600
                    }
                  ]  
              , duration = 4
              , depart = "24.08.2017"

              , videoUrl = Nothing
 
              , description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras aliquet lobortis turpis, nec suscipit diam. Nulla facilisi. Nunc varius nunc sit amet metus faucibus iaculis. Maecenas faucibus condimentum urna, sit amet placerat velit blandit in. Sed tincidunt, est et porta tincidunt, purus augue porttitor velit, et egestas odio est a dui. Integer tincidunt consequat ante nec vehicula. Etiam vehicula diam ipsum, lobortis mattis odio dapibus ac. Nam elementum lobortis ligula, vel pharetra nunc rutrum eu. Duis commodo convallis elit elementum viverra. Nam dapibus ex quis auctor volutpat."

              , features = 
                  [ "Suspendisse volutpat at odio sed dignissim."      
                  , "Donec sit amet sem vulputate neque tempor elementum."
                  , "Sed nec lorem eu felis fringilla faucibus."
                  , "Pellentesque pharetra luctus velit imperdiet lobortis. Praesent rutrum condimentum tempus."
                  ]

              , postDescription = "In eget cursus leo. Sed a ex ex. Nam sit amet est iaculis, maximus magna eu, porta metus. Sed eu ex finibus, rhoncus lectus sit amet, facilisis eros. Pellentesque id ipsum rhoncus, pulvinar justo id, lobortis nisl. Curabitur porttitor mi nibh, sit amet iaculis neque iaculis bibendum. Praesent consectetur mi a magna dapibus, sed placerat lacus interdum. In egestas vel tellus eget tincidunt. Curabitur eros nisi, bibendum a lorem vitae, vehicula interdum ipsum. Sed quis egestas ex."



              },
              { id = "sample-3"
              , name = "Sample Hotel 3"
              , popularity = -3
              , countryId = "crit"
              , stars = 3
              , bgPhotoUrl = "bg_4.jpg"
              , photoUrls = []
              , priceOptions = 
                  [ 
                    { name = "OB"
                    , personCapacity = 1
                    , price = 200
                    },
                    { name = "BB"
                    , personCapacity = 1
                    , price = 250
                    },
                    { name = "OB"
                    , personCapacity = 2
                    , price = 300 
                    }, 
                    { name = "ALL"
                    , personCapacity = 2
                    , price = 800
                    }
                  ] 
            , duration = 5
            , depart = "21.08.2017"

            , videoUrl = Nothing

            , description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras aliquet lobortis turpis, nec suscipit diam. Nulla facilisi. Nunc varius nunc sit amet metus faucibus iaculis. Maecenas faucibus condimentum urna, sit amet placerat velit blandit in. Sed tincidunt, est et porta tincidunt, purus augue porttitor velit, et egestas odio est a dui. Integer tincidunt consequat ante nec vehicula. Etiam vehicula diam ipsum, lobortis mattis odio dapibus ac. Nam elementum lobortis ligula, vel pharetra nunc rutrum eu. Duis commodo convallis elit elementum viverra. Nam dapibus ex quis auctor volutpat."

            , features = 
                  [ "Suspendisse volutpat at odio sed dignissim."      
                  , "Donec sit amet sem vulputate neque tempor elementum."
                  , "Sed nec lorem eu felis fringilla faucibus."
                  , "Pellentesque pharetra luctus velit imperdiet lobortis. Praesent rutrum condimentum tempus."
                  ]

            , postDescription = "In eget cursus leo. Sed a ex ex. Nam sit amet est iaculis, maximus magna eu, porta metus. Sed eu ex finibus, rhoncus lectus sit amet, facilisis eros. Pellentesque id ipsum rhoncus, pulvinar justo id, lobortis nisl. Curabitur porttitor mi nibh, sit amet iaculis neque iaculis bibendum. Praesent consectetur mi a magna dapibus, sed placerat lacus interdum. In egestas vel tellus eget tincidunt. Curabitur eros nisi, bibendum a lorem vitae, vehicula interdum ipsum. Sed quis egestas ex."

            },
            { id = "sample-4"
              , name = "Sample Hotel 4"
              , popularity = -1
              , countryId = "malta"
              , stars = 3
              , bgPhotoUrl = "bg_1.jpg"
              , photoUrls = []
              , priceOptions = 
                  [ 
                    { name = "OB"
                    , personCapacity = 1
                    , price = 400
                    },
                    { name = "BB"
                    , personCapacity = 1
                    , price = 550
                    },
                    { name = "OB"
                    , personCapacity = 2
                    , price = 600 
                    }, 
                    { name = "ALL"
                    , personCapacity = 2
                    , price = 1000
                    }
                  ]   
              , duration = 6
              , depart = "14.08.2017"

              , videoUrl = Just "https://www.youtube.com/embed/1tP2INzqnaQ"

              , description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras aliquet lobortis turpis, nec suscipit diam. Nulla facilisi. Nunc varius nunc sit amet metus faucibus iaculis. Maecenas faucibus condimentum urna, sit amet placerat velit blandit in. Sed tincidunt, est et porta tincidunt, purus augue porttitor velit, et egestas odio est a dui. Integer tincidunt consequat ante nec vehicula. Etiam vehicula diam ipsum, lobortis mattis odio dapibus ac. Nam elementum lobortis ligula, vel pharetra nunc rutrum eu. Duis commodo convallis elit elementum viverra. Nam dapibus ex quis auctor volutpat."

              , features = 
                  [ "Vivamus at felis quis massa hendrerit rutrum."      
                  , "Aliquam erat sem, congue et elementum in, pretium eu eros."
                  , "Suspendisse potenti. Quisque arcu ipsum, pulvinar quis pulvinar feugiat, aliquam ac turpis."
                  , "Fusce rhoncus massa lorem. Etiam feugiat magna aliquet arcu vehicula, vel laoreet enim tincidunt."
                  ]

              , postDescription = "In eget cursus leo. Sed a ex ex. Nam sit amet est iaculis, maximus magna eu, porta metus. Sed eu ex finibus, rhoncus lectus sit amet, facilisis eros. Pellentesque id ipsum rhoncus, pulvinar justo id, lobortis nisl. Curabitur porttitor mi nibh, sit amet iaculis neque iaculis bibendum. Praesent consectetur mi a magna dapibus, sed placerat lacus interdum. In egestas vel tellus eget tincidunt. Curabitur eros nisi, bibendum a lorem vitae, vehicula interdum ipsum. Sed quis egestas ex."
              },  
              { id = "sample-5"
              , name = "Sample Hotel 5"
              , popularity = -5
              , countryId = "ibiza"
              , stars = 3
              , bgPhotoUrl = "bg_2.jpg"
              , photoUrls = []
              , priceOptions = 
                  [ 
                    { name = "OB"
                    , personCapacity = 1
                    , price = 200
                    },
                    { name = "BB"
                    , personCapacity = 1
                    , price = 250
                    },
                    { name = "OB"
                    , personCapacity = 2
                    , price = 300 
                    }, 
                    { name = "ALL"
                    , personCapacity = 2
                    , price = 800
                    }
                  ]
              , duration = 5    
              , depart = "8.08.2017"

              , videoUrl = Nothing

              , description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras aliquet lobortis turpis, nec suscipit diam. Nulla facilisi. Nunc varius nunc sit amet metus faucibus iaculis. Maecenas faucibus condimentum urna, sit amet placerat velit blandit in. Sed tincidunt, est et porta tincidunt, purus augue porttitor velit, et egestas odio est a dui. Integer tincidunt consequat ante nec vehicula. Etiam vehicula diam ipsum, lobortis mattis odio dapibus ac. Nam elementum lobortis ligula, vel pharetra nunc rutrum eu. Duis commodo convallis elit elementum viverra. Nam dapibus ex quis auctor volutpat."

              , features = 
                  [ "Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus."      
                  , "Donec sit amet sem vulputate neque tempor elementum."
                  , "Maecenas congue, tortor ut fringilla interdum, erat metus accumsan ligula, at faucibus augue lorem sed ante."
                  , "Pellentesque pharetra luctus velit imperdiet lobortis. Praesent rutrum condimentum tempus."
                  ]

              , postDescription = "In eget cursus leo. Sed a ex ex. Nam sit amet est iaculis, maximus magna eu, porta metus. Sed eu ex finibus, rhoncus lectus sit amet, facilisis eros. Pellentesque id ipsum rhoncus, pulvinar justo id, lobortis nisl. Curabitur porttitor mi nibh, sit amet iaculis neque iaculis bibendum. Praesent consectetur mi a magna dapibus, sed placerat lacus interdum. In egestas vel tellus eget tincidunt. Curabitur eros nisi, bibendum a lorem vitae, vehicula interdum ipsum. Sed quis egestas ex."


              },
              { id = "sample-6"
              , name = "Sample Hotel 6"
              , popularity = -6
              , countryId = "cyprus"
              , stars = 3
              , bgPhotoUrl = "bg_3.jpg"
              , photoUrls = []
              , priceOptions = 
                  [ 
                    { name = "OB"
                    , personCapacity = 1
                    , price = 150
                    },
                    { name = "BB"
                    , personCapacity = 1
                    , price = 250
                    },
                    { name = "OB"
                    , personCapacity = 2
                    , price = 300 
                    }, 
                    { name = "ALL"
                    , personCapacity = 2
                    , price = 600
                    }
                  ]  
              , duration = 4
              , depart = "24.08.2017"

              , videoUrl = Nothing
 
              , description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras aliquet lobortis turpis, nec suscipit diam. Nulla facilisi. Nunc varius nunc sit amet metus faucibus iaculis. Maecenas faucibus condimentum urna, sit amet placerat velit blandit in. Sed tincidunt, est et porta tincidunt, purus augue porttitor velit, et egestas odio est a dui. Integer tincidunt consequat ante nec vehicula. Etiam vehicula diam ipsum, lobortis mattis odio dapibus ac. Nam elementum lobortis ligula, vel pharetra nunc rutrum eu. Duis commodo convallis elit elementum viverra. Nam dapibus ex quis auctor volutpat."

              , features = 
                  [ "Suspendisse volutpat at odio sed dignissim."      
                  , "Donec sit amet sem vulputate neque tempor elementum."
                  , "Sed nec lorem eu felis fringilla faucibus."
                  , "Pellentesque pharetra luctus velit imperdiet lobortis. Praesent rutrum condimentum tempus."
                  ]

              , postDescription = "In eget cursus leo. Sed a ex ex. Nam sit amet est iaculis, maximus magna eu, porta metus. Sed eu ex finibus, rhoncus lectus sit amet, facilisis eros. Pellentesque id ipsum rhoncus, pulvinar justo id, lobortis nisl. Curabitur porttitor mi nibh, sit amet iaculis neque iaculis bibendum. Praesent consectetur mi a magna dapibus, sed placerat lacus interdum. In egestas vel tellus eget tincidunt. Curabitur eros nisi, bibendum a lorem vitae, vehicula interdum ipsum. Sed quis egestas ex."



              },
              { id = "sample-7"
              , name = "Sample Hotel 7"
              , popularity = -7
              , countryId = "crit"
              , stars = 3
              , bgPhotoUrl = "bg_4.jpg"
              , photoUrls = []
              , priceOptions = 
                  [ 
                    { name = "OB"
                    , personCapacity = 1
                    , price = 200
                    },
                    { name = "BB"
                    , personCapacity = 1
                    , price = 250
                    },
                    { name = "OB"
                    , personCapacity = 2
                    , price = 300 
                    }, 
                    { name = "ALL"
                    , personCapacity = 2
                    , price = 800
                    }
                  ] 
            , duration = 5
            , depart = "21.08.2017"

            , videoUrl = Nothing

            , description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras aliquet lobortis turpis, nec suscipit diam. Nulla facilisi. Nunc varius nunc sit amet metus faucibus iaculis. Maecenas faucibus condimentum urna, sit amet placerat velit blandit in. Sed tincidunt, est et porta tincidunt, purus augue porttitor velit, et egestas odio est a dui. Integer tincidunt consequat ante nec vehicula. Etiam vehicula diam ipsum, lobortis mattis odio dapibus ac. Nam elementum lobortis ligula, vel pharetra nunc rutrum eu. Duis commodo convallis elit elementum viverra. Nam dapibus ex quis auctor volutpat."

            , features = 
                  [ "Suspendisse volutpat at odio sed dignissim."      
                  , "Donec sit amet sem vulputate neque tempor elementum."
                  , "Sed nec lorem eu felis fringilla faucibus."
                  , "Pellentesque pharetra luctus velit imperdiet lobortis. Praesent rutrum condimentum tempus."
                  ]

            , postDescription = "In eget cursus leo. Sed a ex ex. Nam sit amet est iaculis, maximus magna eu, porta metus. Sed eu ex finibus, rhoncus lectus sit amet, facilisis eros. Pellentesque id ipsum rhoncus, pulvinar justo id, lobortis nisl. Curabitur porttitor mi nibh, sit amet iaculis neque iaculis bibendum. Praesent consectetur mi a magna dapibus, sed placerat lacus interdum. In egestas vel tellus eget tincidunt. Curabitur eros nisi, bibendum a lorem vitae, vehicula interdum ipsum. Sed quis egestas ex."

            }
 
            ]
        }
    }
    , view = view, update = update }

{- countriesToLinks : List Country -> List (Html msg) 
countriesToLinks = List.map (\country -> a [href ("/"++country.id)] [text ("Тури на " ++ country.nameLocativeCase)])


viewRightBlock : Model -> Html Msg
viewRightBlock model = 
  nav []
     (countriesToLinks model.countries)        
-}

view : Model -> Html Msg
view model =
  div []
    [(renderLayout (\x -> text "") model)]

updateAppState : (AppState -> AppState) -> Model -> Model
updateAppState f model =
  let appState = model.appState
  in {model | appState = f appState}

phoneIsValid : String -> Bool
phoneIsValid = Regex.contains (Regex.regex "(^\\+?38\\d{10}$)|(^\\d{10}$)")

update : Msg -> Model -> Model
update msg =
  case msg of
    (Models.NavIconClick iconClass) ->
      updateAppState (\st -> { st | selectedNavIcon = iconClass } )
    (SortOptionSelect opt ord) ->
      updateAppState (\st -> { st | currentSortOption = opt , currentSortOrder = ord, currentPage = 1})
    (RouteChange route) ->
      updateAppState (\st -> { st | currentRoute = route})
    LogoClick ->
      updateAppState (\st -> { st | currentRoute = MenuPage, currentFilterByCountry = Nothing, currentSortOption = Popularity, currentSortOrder = Desc, currentPage = 1 })
    SetFilterByCountry country ->
      updateAppState (\st -> { st | currentFilterByCountry = country, currentPage = 1 })
    Pagination delta ->
      updateAppState (\st -> { st | currentPage = st.currentPage + delta})
    FormPhoneChange newPhone ->
      updateAppState (\st -> { st | formPhone = newPhone})
    FormSubmit ->
      updateAppState(\st ->
        if phoneIsValid st.formPhone
        then { st | formSubmitted = True }
        else { st | formFailureMessage = "Перевірте правильність телефону" }
      )
    ToggleBlogEntrySelected id ->
      updateAppState(\st ->
        if st.selectedBlogEntryId == (Just id)
        then { st | selectedBlogEntryId = Nothing }
        else { st | selectedBlogEntryId = (Just id) }
      )