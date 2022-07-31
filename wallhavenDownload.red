
Red [needs: view]

;Build list of id-image pairs
result: collect [
      foreach 
        ; element of html code
        id_candidate 
        ; Break up html result by occurrences of wallpaper links
        split read https://wallhaven.cc/random "href=^"https://wallhaven.cc/w/" 
          [
            element: first split id_candidate "^""
            ;; TODO: find a better way to extract just the id from a line
            ;;; e.g. '123456" code'..... => '123456'

			element: rejoin ["https://w.wallhaven.cc/full/" rejoin [first element] rejoin [second element] "/wallhaven-" element ".jpg"]
			
			; rebuild wallpaper link
            image_url: do [load to-url element]

			;print image_url

            ; if the image downloaded, load and return it
            either none? image_url [][
				
				;Build output and copy in image data
				output: [1 1]
				output/1: element
				
				;Copy needed to avoid referencign the same image!
				output/2: copy [base 800x600 1]
				output/2/3: image_url

				keep output

            ]
          ]
    ] 

;check if the first title is available
;probe first result 

view [tab-panel 800x600 result]
