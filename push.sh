git ls-files | while read file; do touch -d $(git log -1 --format="@%ct" "$file") "$file"; done
###
 # @Author: starrysky9959 starrysky9651@outlook.com
 # @Date: 2022-11-25 00:14:38
 # @LastEditors: starrysky9959 starrysky9651@outlook.com
 # @LastEditTime: 2022-11-25 00:14:37
 # @Description:  
### 
git push origin master