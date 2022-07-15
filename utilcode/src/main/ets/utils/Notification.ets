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
import prompt from '@system.prompt';

export class notificationUtil {


  constructor() {
    console.log("called notification class");

  }

  isNotificationEnable() {
    notification.isNotificationEnabled().then((data) => {
      console.info('Operation succeeded. Data: ' + JSON.stringify(data))
      if (data == true) {
        console.log("Notification is Enabled")
      } else if (data == false) {
        console.log("Notification is disabled")
      } else {
        console.log("no proper reply")
      }
    })
      .catch((err) => {
        console.error('Operation failed. Cause: ' + JSON.stringify(err));
      });
  }

  publish(data1) {
    notification.publish(data1)
      .then((data) => {
        prompt.showToast({
          message: "published",
          duration: 2000,
        });
        console.info('Notification Published ' + JSON.stringify(data))
      }).catch((err) => {
      console.error('Operation failed. Cause: ' + JSON.stringify(err));
      prompt.showToast({
        message: "publish error",
        duration: 2000,
      });
    });
  }

  publish2(data1) {
    var myContent = {
      contentType: notification.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
      normal: {
        text: 'text',
        title: 'title'
      }
    };
    var request = {
      content: myContent,
    };
    notification.publish(request, (err, data) => {
      if (err) {
        console.error('Operation failed. Cause: ' + JSON.stringify(err));
        prompt.showToast({
          message: "publish error !",
          duration: 2000,
        });
        return;
      }
      console.info('Operation succeeded. Data: ' + JSON.stringify(data))
      prompt.showToast({
        message: "published",
        duration: 2000,
      });
    });
  }

  cancel(id) {
    notification.cancel(id).then((data) => {
      console.info('Operation succeeded. Data: ' + JSON.stringify(data))
    }).catch((err) => {
      console.error('Operation failed. Cause: ' + JSON.stringify(err));
    });
  }

//    cancel(id , label){
//      notification.cancel(id, label).then((data) => {
//        console.info('Operation succeeded. Data: ' + JSON.stringify(data))
//      }).catch((err) => {
//        console.error('Operation failed. Cause: ' + JSON.stringify(err));
//      });
//    }

  cancelAll() {
    notification.cancelAll()
      .then((data) => {
        console.info('Cancelled all Notification ' + JSON.stringify(data))
      }).catch((err) => {
      console.error('Operation failed. Cause: ' + JSON.stringify(err));
    });
  }

  addContent(data, text, title) {
    var dict = []
    dict.push({ content: data, normal: { text: text, title: title } })
    return dict
  }

  addId(data, request: number) {
    return data[0].id = request
  }

  addSlotType(data, request) {
    return data[0].slotType = request
  }

  addisOngoing(data, request: Boolean) {
    return data[0].isOngoing = request
  }

  addisUnRemovable(data, request: Boolean) {
    return data[0].isUnremovable = request
  }

  addDeliveryTime(data, request: number) {
    return data[0].deliveryTime = request
  }

  addTapDismissed(data, request: Boolean) {
    return data[0].tapDismissed = request
  }

  addAutoDeletedTime(data, request: number) {
    return data[0].autoDeletedTime = request
  }

  addWantAgent(data, request) {
    return data[0].wantAgent = request
  }

  addExtraInfo(data, request) {
    return data[0].extraInfo = request
  }

  addColor(data, request: number) {
    return data[0].color = request
  }

  addColorEnabled(data, request: Boolean) {
    return data[0].colorEnabled = request
  }

  addisAlertOnce(data, request: Boolean) {
    return data[0].isAlertOnce = request
  }

  addisStopwatch(data, request: Boolean) {
    return data[0].isStopwatch = request
  }

  addisCountDown(data, request: Boolean) {
    return data[0].isCountDown = request
  }

  addisFloatingIcon(data, request: Boolean) {
    return data[0].isFloatingIcon = request
  }

  addLabel(data, request: string) {
    return data[0].label = request
  }

  addBadgeIconStyle(data, request: number) {
    return data[0].badgeIconStyle = request
  }

  addShowDeliveryTime(data, request: Boolean) {
    console.log(JSON.stringify(data))
    return data[0].showDeliveryTime = request
  }

  addActionButtons(data, request) {
    return data[0].actionButtons = request
  }

  addSmallIcon(data, request) {
    return data[0].smallIcon = request
  }

  addLargeIcon(data, request) {
    return data[0].largeIcon = request
  }

  addReadonlyCreatorBundleName(data, request) {
    return data[0].readonlycreatorBundleName = request
  }

  addReadonlyCreatorUid(data, request) {
    return data[0].readonlycreatorUid = request
  }

  addReadonlyCreatorPid(data, request) {
    return data[0].readonlycreatorPid = request
  }
}
