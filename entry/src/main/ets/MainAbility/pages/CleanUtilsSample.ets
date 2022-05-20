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

import { CleanUtils } from '@ohos/utilcode';
import prompt from '@system.prompt';
import dataStorage from '@ohos.data.storage';
import ability_featureAbility from '@ohos.ability.featureAbility';
import dataRdb from '@ohos.data.rdb'

const STORE_CONFIG = { name: 'book.db' }
const SQL_CREATE_TABLE = 'CREATE TABLE IF NOT EXISTS book(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, introduction TEXT NOT NULL)'

@Entry
@Component
struct Index {
  @State data: string = 'path'
  @State dbText: string = ""
  @State dirText: string = ""
  private cleanutils: CleanUtils = new CleanUtils();

  aboutToAppear() {
    var context = ability_featureAbility.getContext()
    context.getFilesDir((err, path) => {
      if (err) {
        console.error('getFilesDir failed. err: ' + JSON.stringify(err));
        return;
      }
      this.data = path;

      let storage = dataStorage.getStorageSync(path + '/sharedPreference')
      var observer = function (key) {
        console.info("The key of " + key + " changed.")
      }
      storage.on('change', observer)
      storage.putSync('startup', 'auto')
      storage.flushSync()
      storage.off('change', observer)
    })

    let promise = dataRdb.getRdbStore(this, STORE_CONFIG, 1);
    promise.then(async (rdbStore) => {
      await rdbStore.executeSql(SQL_CREATE_TABLE, null)
    }).catch((err) => {
      console.info('Error in obtaining RDB Store: ' + err.message);
    })

  }

  cleanInternalCache() {
    this.cleanutils.cleanInternalCache().then((path) => {
      this.data = path;
      prompt.showToast({
        message: "Internal Cache Delete Success => " + this.data,
        duration: 2000
      })
    })
  }

  cleanInternalFiles() {
    this.cleanutils.cleanInternalFiles().then((path) => {
      this.data = path;
      prompt.showToast({
        message: "Internal Files Delete Success: " + path,
        duration: 2000
      })
    })
  }

  cleanInternalSp() {
    this.cleanutils.cleanInternalSp().then((path) => {
      this.data = path;
      prompt.showToast({
        message: "Shared Preference Delete Success => " + this.data,
        duration: 2000
      })
    })
  }

  cleanInternalDbByName(dbName: string) {
    this.cleanutils.cleanInternalDbByName(dbName).then((name) => {
      console.log('Clean Internal DB By Name');
    })
  }

  cleanInternalDbs() {
    this.cleanutils.cleanInternalDbs().then((path) => {
      this.data = path;
      console.log("Internal Databases Cleaned: " + this.data);
      prompt.showToast({
        message: "Internal Database Delete Success => " + this.data,
        duration: 2000
      })
    })
  }

  cleanCustomDir(dirName: string) {
    this.cleanutils.cleanCustomDir(dirName).then((name) => {
          console.log('Clean Custom Directory');
    })
  }

  build() {
    Column() {
      Row() {
        Text('CLEAN UTILS')
          .fontSize(30)
          .fontColor(Color.Brown)
          .fontWeight(FontWeight.Bold)
      }.height('50').margin(10).align(Alignment.Center)

      Row() {
        Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
          Button('Clean Cache', { type: ButtonType.Normal, stateEffect: true }).onClick((event: ClickEvent) => {
            this.cleanInternalCache();
          })
        }
      }.height('50').margin(10).width(400)

      Row() {
        Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
          Button('Clean Files', { type: ButtonType.Normal, stateEffect: true }).onClick((event: ClickEvent) => {
            this.cleanInternalFiles();
          })
        }
      }.height(50).margin(10).width(400)

      Row() {
        Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
          Button('Clean Shared Preferences', { type: ButtonType.Normal, stateEffect: true })
            .onClick((event: ClickEvent) => {
              this.cleanInternalSp();
            })
        }
      }.height(50).margin(10).width(400)

      Row() {
        Column() {
          Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceEvenly }) {
            TextInput({ placeholder: 'Database to be Cleaned' })
              .type(InputType.Normal)
              .enterKeyType(EnterKeyType.Done)
              .id('dbName')
              .fontSize(1)
              .onChange((value: string) => {
                this.dbText = value
              })
              .onSubmit((enterKey) => {
                console.log('Database name Submitted')
              })
            Button('Clean the DataBase', { type: ButtonType.Normal, stateEffect: true })
              .onClick((event: ClickEvent) => {
                this.cleanInternalDbByName(this.dbText);
              })
              .borderWidth(2)
              .borderRadius(10)
          }
        }
      }.height(50).margin(5)

      Row() {
        Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
          Button('Clean all Internal DataBase', { type: ButtonType.Normal, stateEffect: true })
            .onClick((event: ClickEvent) => {
              this.cleanInternalDbs();
            })
        }
      }.height(50).margin(10).width(400)

      Row() {
        Column() {
          Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceEvenly }) {
            TextInput({ placeholder: 'Input Directory Path' })
              .type(InputType.Normal)
              .enterKeyType(EnterKeyType.Done)
              .id('dbName')
              .fontSize(1)
              .onChange((value: string) => {
                this.dirText = value
              })
              .onSubmit((enterKey) => {
                console.log('Directory Path Submitted')
              })
            Button('Clean the Directory', { type: ButtonType.Normal, stateEffect: true })
              .onClick((event: ClickEvent) => {
                this.cleanCustomDir(this.dirText);
              })
              .borderWidth(2)
              .borderRadius(10)
          }
        }
      }.height(50).margin(5)
    }
  }
}