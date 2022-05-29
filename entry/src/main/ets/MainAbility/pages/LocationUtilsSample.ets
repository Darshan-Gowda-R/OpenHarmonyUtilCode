// @ts-nocheck
@Entry
@Component
struct Index {
  @State message: string = 'LocationUtil Library'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }
}


//import { LocationUtils } from "C:/Users/dg205/git/LocationUtils/foke/OpenHarmonyUtilCode/utilcode/src/main/ets/utils/LocationUtils"
import { LocationUtils } from "@ohos/utilcode"
import { OnLocationChangeListener } from "@ohos/utilcode"
import { myLocationListener } from "@ohos/utilcode"
import geolocation from '@ohos.geolocation';

let locationUtils = new LocationUtils();
let myLocation = new myLocationListener

locationUtils.isGpsEnabled()
locationUtils.isLocationEnabled()
locationUtils.register(10,20,112)
locationUtils.unregister()
locationUtils.getCountryName(12.433,123.3451)
locationUtils.getStreet(12.433,123.3451)
let address = locationUtils.getAddress(12.433,123.3451)
locationUtils.getLocality(12.433,123.3451)
myLocation.onStatusChanged()
myLocation.onLocationChanged(address)
