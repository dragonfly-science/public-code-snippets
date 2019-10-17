load('plot_data.Rdata')
require(cowplot)
require(multiscales)
require(sf)
require(maps)
require(viridis)


wrld <- st_as_sf(map('world', plot = FALSE, fill = TRUE,wrap = c(0,360)))

ggplot() +
  geom_sf(aes(fill=zip(`HA 5`/max(`HA 5`),V)),data=ol)+
  geom_sf(data=wrld) +
  coord_sf(xlim=c(130,220),ylim=c(-60,55)) + 
  geom_hline(yintercept = c(30,-30),linetype=2)+
  bivariate_scale("fill",
                  pal_vsup(values = viridis(8),max_desat = 0.1),
                  limits = list(c(0, 1), c(0,1)),
                  breaks = list(waiver(), waiver()),
                  name = c("Relative abundance", "Relative CV"),
                  labels = list(waiver(), waiver()),
                  trans = list('identity','identity'),
                  guide = "colourfan"
  ) +
  xlab('Longitude') + 
  ylab('Latitude')+
  theme_cowplot()+
  theme(
    legend.key.size = grid::unit(0.8, "cm"),
    legend.title.align = 0.5,
    legend.text = element_text(size=9),
    plot.margin = margin(5.5, 20, 5.5, 5.5)
  )
