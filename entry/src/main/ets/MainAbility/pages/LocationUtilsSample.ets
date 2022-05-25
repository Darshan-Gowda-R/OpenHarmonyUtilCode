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


import { LocationUtils } from "../MainAbility/LocationUtils"
import { OnLocationChangeListener } from "../MainAbility/LocationUtils"
import { myLocationListener } from "../MainAbility/LocationUtils"
import geolocation from '@ohos.geolocation';

let locationUtils = new LocationUtils();
let myLocation = new myLocationListener

locationUtils.isGpsEnabled()
locationUtils.isLocationEnabled()
locationUtils.register(10,20,112)
locationUtils.unregister()
locationUtils.getCountryName(12.433,123.3451)
locationUtils.getStreet(12.433,123.3451)
locationUtils.getAddress(12.433,123.3451)
locationUtils.getLocality(12.433,123.3451)

