Red [needs: view]

;Build list of id-image pairs
result: collect [
      foreach 
        ; element of html code
        id_candidate 
        ; Break up html result by occurrences of wallpaper links
        split read https://alpha.wallhaven.cc/random "href=^"https://alpha.wallhaven.cc/wallpaper/" 
          [
            element: first split id_candidate "^""
            ;; TODO: find a better way to extract just the id from a line
            ;;; e.g. '123456" code'..... => '123456'

            ; rebuild wallpaper link
            image_url: do [load to-url rejoin ["https://wallpapers.wallhaven.cc/wallpapers/full/wallhaven-" element ".jpg"]]

            ; if the image downloaded, load and return it
            either none? image_url [][

              keep reduce [element image_url]

            ]
          ]
    ] 


view [
  tab-panel 800x600 result
]