

	case "$mime_type" in
	( text/* | application/json | application/javascript | \
	application/pgp-encrypted | inode/x-empty | application/octet-stream )
		app=$(menu_select <<-\EOF
		$EDITOR
		$EDITOR (new terminal)
		nano
		nano (new terminal)
		EOF
		)
		case "$app" in
		(1) "${EDITOR:-nvim}" $fx ;;
		(2) dem "${TERMINAL:-alacritty}" -e "$EDITOR" $fx ;;
		(3) nano $fx ;;
		(4) dem "${TERMINAL:-alacritty}" -e nano $fx ;;
		esac
	;;

	(image/svg+xml | image/png | image/jpeg | image/gif )
		app=$(menu_select <<-\EOF
		micro
		gimp
		tmux-open
		mpv
		krita
		inkscape
		chafa
		jp2a
		mediainfo
		EOF
		)
		case "$app" in
		(1) dem vimiv $fx ;;
		(2) dem gimp $fx ;;
		(3)
			case "$(tty)" in
			# Demonizing on tty makes it impossible to quit
			("/dev/tty"*) "${MPV:-mpv}" --keep-open=yes $fx ;;
			(*) dem "${MPV:-mpv}" --keep-open=yes $fx ;;
			esac
		;;
		(4) dem krita $fx ;;
		(5) dem inkscape $fx ;;
		(6) dem chafa $f ;; 
		(7) dem jp2a $f ;; 
		esac
	;;

	(image/x-*)
		app=$(menu_select <<-\EOF
		gimp
		vimiv
		mpv
		EOF
		)
		case "$app" in
		(1) dem gimp $fx ;;
		(2) dem vimiv $fx ;;
		(3)
			case "$(tty)" in
			# Demonizing on tty makes it impossible to quit
			("/dev/tty"*) "${MPV:-mpv}" --keep-open=yes $fx ;;
			(*) dem "${MPV:-mpv}" --keep-open=yes $fx ;;
			esac
			;;
		esac
	;;

	(audio/*)
		app=$(menu_select <<-\EOF
		mpv (force terminal)
		mpv (background)
		mpv (background, only audio)
		mpv (foreground)
		mpv (foreground, only audio)
		mpv (force window)
		EOF
		)
		case "$app" in
		(1) dem "${TERMINAL:-alacritty}" -e "$MPV" --audio-display=no $fx ;;
		(2) dem "${MPV:-mpv}" $fx ;;
		(3) dem "${MPV:-mpv}" --audio-display=no $fx ;;
		(4) "${MPV:-mpv}" $fx ;;
		(5) echo; "${MPV:-mpv}" --audio-display=no $fx ;;
		(6) dem "${MPV:-mpv}" --force-window $fx ;;
		esac
	;;

	(video/*)
		app=$(menu_select <<-\EOF
		mpv
		mpv (background, only audio)
		mpv (foreground, only audio)
		kdenlive
		EOF
		)
		case "$app" in
		(1) dem "${MPV:-mpv}" $fx ;;
		(2) dem "${MPV:-mpv}" --video=no --audio-display=no $fx ;;
		(3) echo; "${MPV:-mpv}" --video=no --audio-display=no $fx ;;
		(4) dem "${VIDEO_EDITOR:-kdenlive}" $fx ;;
		esac
	esac
}}

