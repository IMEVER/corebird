/*  This file is part of corebird, a Gtk+ linux Twitter client.
 *  Copyright (C) 2013 Timm Bäder
 *
 *  corebird is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  corebird is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with corebird.  If not, see <http://www.gnu.org/licenses/>.
 */

class AddImageButton : Gtk.Widget {
  private const int MIN_WIDTH  = 40;
  private const int MAX_HEIGHT = 150;
  private const int MIN_HEIGHT = 100;
  private const int ICON_SIZE  = 32;
  public string image_path;
  public Cairo.ImageSurface? surface;

  public signal void deleted ();

  private double delete_factor = 1.0;
  private uint64 delete_transition_start;

  construct {
    this.set_has_window (false);
  }

  public void get_draw_size (out int    width,
                             out int    height,
                             out double scale) {
    if (this.surface == null) {
      width  = 0;
      height = 0;
      scale  = 0.0;
      return;
    }

    width  = this.get_allocated_width ();
    height = this.get_allocated_height ();
    double scale_x = (double)width / this.surface.get_width ();
    double scale_y = (double)height / this.surface.get_height ();

    scale = double.min (double.min (scale_x, scale_y), 1.0) * delete_factor;

    width  = (int)(this.surface.get_width ()  * scale);
    height = (int)(this.surface.get_height () * scale);
  }

  public override void snapshot (Gtk.Snapshot snapshot) {
    /* Draw thumbnail */
    if (this.surface != null) {
      Graphene.Rect bounds = {};
      int draw_width, draw_height;
      double scale;

      var texture = Cb.Utils.surface_to_texture (this.surface,
                                                 this.get_scale_factor ());

      this.get_draw_size (out draw_width, out draw_height, out scale);
      bounds.origin.x = 0;
      bounds.origin.y = 0;
      bounds.size.width = draw_width;
      bounds.size.height = draw_height;

      if (draw_width > 0 && draw_height > 0) {
        snapshot.append_texture (texture, bounds, "Texture");
      }

      // TODO: What to do here?
      //style_context.render_check (ct,
                                  //(widget_width / 2.0) - (ICON_SIZE / 2.0),
                                  //(widget_height / 2.0) - (ICON_SIZE / 2.0),
                                  //ICON_SIZE,
                                  //ICON_SIZE);
    }
  }

  public override Gtk.SizeRequestMode get_request_mode () {
    return Gtk.SizeRequestMode.HEIGHT_FOR_WIDTH;
  }

  public override void measure (Gtk.Orientation orientation,
                                int             for_size,
                                out int         min,
                                out int         nat,
                                out int         min_baseline = null,
                                out int         nat_baseline = null) {
    int media_size;
    int other_media_size;
    int min_size;

    if (this.surface == null) {
      if (orientation == Gtk.Orientation.HORIZONTAL) {
        media_size = MIN_WIDTH;
        other_media_size = MAX_HEIGHT;
        min_size = MIN_WIDTH;
      } else {
        media_size = MAX_HEIGHT;
        other_media_size = MIN_WIDTH;
        min_size = MIN_HEIGHT;
      }
    } else {
      if (orientation == Gtk.Orientation.HORIZONTAL) {
        media_size = this.surface.get_width ();
        other_media_size = this.surface.get_height ();
        min_size = MIN_WIDTH;
      } else {
        media_size = this.surface.get_height ();
        other_media_size = this.surface.get_width ();
        min_size = MIN_HEIGHT;
      }
    }

    if (for_size == -1) {
      min = (int)(int.min (media_size, min_size) * delete_factor);
      nat = (int)(media_size * delete_factor);
    } else {
      int size = int.min (media_size, (int)(media_size * for_size));
      if (orientation == Gtk.Orientation.HORIZONTAL) {
        size = int.max (MIN_WIDTH, size);
        min = nat = (int)(size * this.delete_factor);
      } else {
        size = int.min (MAX_HEIGHT, size);
        min = MIN_HEIGHT;
        nat = int.max (min, (int)(size * this.delete_factor));
      }

      min = nat = (int)(size * this.delete_factor);
    }

    min_baseline = -1;
    nat_baseline = -1;
  }

  private bool delete_tick_cb (Gtk.Widget     widget,
                               Gdk.FrameClock frame_clock) {
    uint64 now = frame_clock.get_frame_time ();

    double t = (now - this.delete_transition_start) / (double)(TRANSITION_DURATION* 1);

    t = ease_out_cubic (t);
    this.delete_factor = 1.0 - t;
    this.queue_resize ();

    if (t >= 1.0) {
      this.delete_factor = 1.0;
      this.deleted ();
      return GLib.Source.REMOVE;
    }

    return GLib.Source.CONTINUE;
  }

  public void start_remove () {
    if (!this.get_realized ()) return;

    this.delete_transition_start = this.get_frame_clock ().get_frame_time ();
    this.add_tick_callback (delete_tick_cb);
  }
}
