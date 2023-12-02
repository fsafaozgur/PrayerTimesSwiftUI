
# PrayerTimes Uygulaması

## Giriş
Proje kapsamında; kaynak olarak bir Namaz Vakitleri API kullanılarak Türkiye'de yer alan tüm şehirlerdeki namaz vakitlerini kullanıcıya sunan bir Namaz Vakti uygulaması MVVM tasarım kalıbı ile tasarlanmıştır. 

## Hedef
Proje ile birlikte; Namaz Vakti API 'a istek göndererek istediğimiz şehre ait namaz vakit bilgilerinin JSON formatında alınması ve bu bilgilerin kullanıcıya bir arayüz yardımı ile sunulması işlemlerinin MVVM tasarım kalıbı ile nasıl tasarlanacağının ortaya konulması amaçlanmıştır.

## Uygulama Kullanımı
Uygulama ilk olarak yerel bir JSON dosyasından Türkiye'de yer alan şehirlerin listesini almakta ve bunları kullanıcıya bir arayüz yardımı ile listelemektedir.

Kullanıcı tarafından listeden seçilen şehre ait namaz vakit bilgileri, Namaz Vakti API 'dan JSON formatında alınarak, bir arayüz yardımıyla kullanıcıya sunulmaktadır.

API yalnızca Türkiyede bulunan şehirlere ait namaz vakit bilgilerini sunduğu için diğer ülkeler dahil edilmemiştir. Yalnızca örnek olarak eklenmiştir.