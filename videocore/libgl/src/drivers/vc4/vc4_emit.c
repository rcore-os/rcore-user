#include "vc4_context.h"

void vc4_emit_state(struct vc4_context *vc4)
{
	if (vc4->dirty & VC4_DIRTY_VIEWPORT) {
		float *vpscale = vc4->viewport.scale;
		float *vptranslate = vc4->viewport.translate;
		float vp_minx = -vpscale[0] + vptranslate[0];
		float vp_maxx = vpscale[0] + vptranslate[0];
		float vp_miny = -vpscale[1] + vptranslate[1];
		float vp_maxy = vpscale[1] + vptranslate[1];

		uint32_t minx, miny, maxx, maxy;
		minx = vp_minx >= 0 ? vp_minx : 0;
		miny = vp_miny >= 0 ? vp_miny : 0;
		maxx = vp_maxx <= vc4->draw_width ? vp_maxx : 0;
		maxy = vp_maxy <= vc4->draw_height ? vp_maxy : 0;

		cl_u8(&vc4->bcl, VC4_PACKET_CLIP_WINDOW);
		cl_u16(&vc4->bcl, minx);
		cl_u16(&vc4->bcl, miny);
		cl_u16(&vc4->bcl, maxx - minx);
		cl_u16(&vc4->bcl, maxy - miny);

		if (minx < vc4->draw_min_x)
			vc4->draw_min_x = minx;
		if (miny < vc4->draw_min_y)
			vc4->draw_min_y = miny;
		if (maxx > vc4->draw_max_x)
			vc4->draw_max_x = maxx;
		if (maxy > vc4->draw_max_y)
			vc4->draw_max_y = maxy;
	}

	if (vc4->dirty & (VC4_DIRTY_RASTERIZER | VC4_DIRTY_ZSA)) {
		uint32_t rasterizer_config_bits[3];
		rasterizer_config_bits[0] = VC4_CONFIG_BITS_ENABLE_PRIM_FRONT |
					    VC4_CONFIG_BITS_ENABLE_PRIM_BACK;
		rasterizer_config_bits[1] = 0;
		rasterizer_config_bits[2] = 0;

		cl_u8(&vc4->bcl, VC4_PACKET_CONFIGURATION_BITS);
		cl_u8(&vc4->bcl,
		      rasterizer_config_bits[0] | vc4->zsa.config_bits[0]);
		cl_u8(&vc4->bcl,
		      rasterizer_config_bits[1] | vc4->zsa.config_bits[1]);
		cl_u8(&vc4->bcl,
		      rasterizer_config_bits[2] | vc4->zsa.config_bits[2]);
	}

	if (vc4->dirty & VC4_DIRTY_VIEWPORT) {
		cl_u8(&vc4->bcl, VC4_PACKET_CLIPPER_XY_SCALING);
		cl_f(&vc4->bcl, vc4->viewport.scale[0] * 16.0f);
		cl_f(&vc4->bcl, vc4->viewport.scale[1] * 16.0f);

		cl_u8(&vc4->bcl, VC4_PACKET_CLIPPER_Z_SCALING);
		cl_f(&vc4->bcl, vc4->viewport.scale[2]);
		cl_f(&vc4->bcl, vc4->viewport.translate[2]);

		cl_u8(&vc4->bcl, VC4_PACKET_VIEWPORT_OFFSET);
		cl_u16(&vc4->bcl, 16 * vc4->viewport.translate[0]);
		cl_u16(&vc4->bcl, 16 * vc4->viewport.translate[1]);
	}
}
