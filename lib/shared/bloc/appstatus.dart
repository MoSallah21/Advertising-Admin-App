abstract class AppState{}

class AppInitState extends AppState{}

class AppChangeSelectedRadioState extends AppState{}

class AppChangeDropDownState extends AppState{}
// add Ad
class AppAddAdLoadingState  extends AppState{}

class AppAddAdSuccessState  extends AppState{}

class AppAddAdErrorState  extends AppState{}

// add Category
class AppAddCategoryLoadingState  extends AppState{}

class AppAddCategorySuccessState  extends AppState{}

class AppAddCategoryErrorState  extends AppState{}
//pickAdPhoto
class AppPickedPhotoSuccessState  extends AppState{}

class AppPickedPhotoErrorState  extends AppState{}
//pickCatPhoto

class AppCategoryPickedPhotoSuccessState  extends AppState{}

class AppCategoryPickedPhotoErrorState  extends AppState{}

class RestTimePicker  extends AppState{}

class AppChangeSortState  extends AppState{}

class SetTimePicker  extends AppState{}
//delete Ad
class AppDeleteAdErrorState  extends AppState{}

class AppDeleteAdSuccessState  extends AppState{}

//delete category

class AppDeleteCatErrorState  extends AppState{}

class AppDeleteCatSuccessState  extends AppState{}


//notification
class NotificationSuccessStatus extends AppState{}

class NotificationLoadingStatus extends AppState{}

class NotificationErrorStatus extends AppState{}
//vip
class ChangeVip extends AppState{}


