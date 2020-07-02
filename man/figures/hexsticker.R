library(hexSticker)
library(magrittr)
library(ggplot2)

# generate sticker --------------------------------------------------------

f <- function(x) - x^2

p <- ggplot(data = data.frame(x = 0), mapping = aes(x = x)) +
  stat_function(fun = f, colour = "#ffffff", size = 2) + xlim(-3,3) +
  geom_vline(xintercept = 0, colour = "#ffffff", linetype = "dashed") +
  geom_hline(yintercept = 0, colour = "#ffffff", linetype = "dashed") +
  theme_void() +
  theme_transparent()

sticker(p,
        package = "rthop",
        p_size = 30,
        p_y = 1.5,
        p_color = "#ffffff",
        s_x = 1,
        s_y = .7,
        s_width = 1,
        s_height = 1,
        h_size = 3,
        h_color = "#14141f",
        h_fill = "#1f1f2e",
        filename="man/figures/hexsticker.png")

