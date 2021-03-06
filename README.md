# Flutter Provider Application Starter


A new Flutter application starter bundled with Provider package for state management.


## 1. Getting started
In order to use this starter in your project, do the following step-by-step:

**1. Clone this repo to your folder:**

`git clone https://gitlab.extrawest.com/andriy.gulak/flutter-provider-application-starter.git`

**2. Change directory to the previously cloned folder**

`cd flutter-provider-application-starter/ `

**3. Remove existing .git folder**

`rm -rf .git `

**4. Initialize empty folder with git**

`git init`

**5. Set remote url to your empty repository**

`git remote set-url origin https://gitlab.extrawest.com/user.name/your_empty_repository.git`

**6. Add all files to git**

`git add .`

**7. Commit all the files with 'initial commit' commit message**

`git commit -m "initial commit"`

**8. Push to remote repository**

`git push -u origin master`


## 2. [Change the app name, package name and bundleId (Android & iOS)](https://gitlab.extrawest.com/internal/knowledge-base/-/blob/master/mobile-dev/flutter/tips_and_tricks.md#change-the-app-name-package-name-and-bundleid-android-ios)

## Implemented Features

- MVVM (Provider+ChangeNotifiers) state sharing and state managing solution
- Fully featured localization / internationalization (i18n):
    - Pluralization support
    - Supports both languageCode (en) and languageCode_countryCode (en_US) locale formats
    - Automatically save & restore the selected locale
    - Full support for right-to-left locales
    - Fallback locale support in case the system locale is unsupported
    - Supports both inline or nested JSON      
- NOSQL database integration (SEMBAST)
- Light/Dark theme configuration
- Dynamic Themes changing using Provider
- Automatic font selection based on the thickness of the glyphs applied.
- API client configuration
- DEV/STAGE/PROD application configuration
- Multilevel configurable logger
- Static analysis tool integration (flutter_lints package + custom rules config)
- Common widgets sharing and reusing example

## Localization

### 1. Update en.json and other json dictionaries under the assets/i18n folder
### 2. Load assets:

```shell
flutter pub run easy_localization:generate --source-dir assets/i18n
```

### 3. Generate static keys for translations

```shell
flutter pub run easy_localization:generate -f keys -o locale_keys.g.dart --source-dir assets/i18n
```

## TODO
- Add auto read from cache
- Add resolution aware images

### Contributing
1. Fork it!
1. Create your feature branch: `git checkout -b new-cool-tip`
1. Commit your changes: `git commit -am 'Added new tip'`
1. Push to the branch: `git push origin new-cool-tip`
1. Submit a pull request.

---
Created by @andriy.gulak
[Extrawest.com](https://www.extrawest.com), 2022
---
