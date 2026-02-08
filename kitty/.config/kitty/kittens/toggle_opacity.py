from kitty.boss import Boss
import kitty.fast_data_types as f

from kittens.tui.handler import result_handler


def main(args: list[str]) -> None:
    pass


@result_handler(no_ui=True)
def handle_result(
    args: list[str],
    answer: str,
    target_window_id: int,
    boss: Boss,
) -> None:
    desired_opacity = 1.0

    os_window_id = f.current_focused_os_window_id()
    current_opacity = f.background_opacity_of(os_window_id)

    new_opacity = (
        "default" if current_opacity == desired_opacity else str(desired_opacity)
    )

    boss.set_background_opacity(new_opacity)
