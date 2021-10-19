source("3_visualize/src/plot_timeseries.R")

p3_targets_list <- list(
  tar_target(
    p3_figure_1_png,
    plot_nwis_timeseries(fileout = "3_visualize/out/p3_figure_1.png", p2_site_data_styled,
                         width = 12, height = 7, units = "in"),
    format = "file"
  )
)