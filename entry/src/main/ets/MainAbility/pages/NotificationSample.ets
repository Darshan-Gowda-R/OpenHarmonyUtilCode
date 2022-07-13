/*
* Copyright (C) 2022 Application library engineering group.
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/
import router from '@system.router';
import notification from '@ohos.notification';
import notification1 from '@system.notification';
import wantAgent from '@ohos.wantAgent';
import featureAbility from '@ohos.ability.featureAbility';
import {notificationUtil} from "../../../../../../utilcode/src/main/ets/utils/Notification"
import prompt from '@system.prompt';


var notificationRequest2 = []

let notificationRequest1 = {"content":notification.ContentType.NOTIFICATION_CONTENT_MULTILINE,"id":"2056","slotTypeMock":"null"}

notificationRequest2.push({content:notification.ContentType.NOTIFICATION_CONTENT_CONVERSATION})

notificationRequest2[0].id="2056"
//notificationRequest.entries(0,"darshan"="hi_Bro")
console.log(JSON.stringify(notificationRequest2))

var indexedArray1: {[key: string]: number} = {
  foo: 123,
  bar: 456
}
var dict = []; // create an empty array

dict.push({
  key:   "keyName",
  value: "the value"
});
dict.push({
  id: "2056",
  content :"The Content"
})
dict[0].id="2056"
console.log("Dictionary =>   "+ JSON.stringify(dict))
var notificationUtilTest : notificationUtil  = new notificationUtil()
var data = {}
data = notificationUtilTest.addContent(notification.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,"hi_i_am_content","notify")
notificationUtilTest.addId(data,2056)
console.log("hi_data +   .... "+JSON.stringify(data))

@Entry
@Component
struct Index {
  build() {
    Row() {
      Column() {
        Button('publish')
          .width(400)
          .height(50)
          .onClick((event: ClickEvent) => {
            notificationUtilTest.publish(data)
            notificationUtilTest.publish2(data)
          })
        Button('cancel-id')
          .width(500)
          .height(60)
          .onClick((event: ClickEvent) => {
            notificationUtilTest.cancel(2056)
          })
        Button('label')
          .width(500)
          .height(60)
          .onClick((event: ClickEvent) => {
            notificationUtilTest.addLabel(data,"hi_dude")
            console.log(JSON.stringify(data))
          })
      }.width('100%')
    }.height('100%')
  }
}