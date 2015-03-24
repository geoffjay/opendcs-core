/* main.c generated by valac 0.26.1, the Vala compiler
 * generated from main.vala, do not modify */


#include <glib.h>
#include <glib-object.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>


#define ASYNC_BUS_TYPE_MULTIPLEXER (async_bus_multiplexer_get_type ())
#define ASYNC_BUS_MULTIPLEXER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), ASYNC_BUS_TYPE_MULTIPLEXER, AsyncBusMultiplexer))
#define ASYNC_BUS_MULTIPLEXER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), ASYNC_BUS_TYPE_MULTIPLEXER, AsyncBusMultiplexerClass))
#define ASYNC_BUS_IS_MULTIPLEXER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), ASYNC_BUS_TYPE_MULTIPLEXER))
#define ASYNC_BUS_IS_MULTIPLEXER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), ASYNC_BUS_TYPE_MULTIPLEXER))
#define ASYNC_BUS_MULTIPLEXER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), ASYNC_BUS_TYPE_MULTIPLEXER, AsyncBusMultiplexerClass))

typedef struct _AsyncBusMultiplexer AsyncBusMultiplexer;
typedef struct _AsyncBusMultiplexerClass AsyncBusMultiplexerClass;
typedef struct _AsyncBusMultiplexerPrivate AsyncBusMultiplexerPrivate;

struct _AsyncBusMultiplexer {
	GObject parent_instance;
	AsyncBusMultiplexerPrivate * priv;
};

struct _AsyncBusMultiplexerClass {
	GObjectClass parent_class;
};


static gpointer async_bus_multiplexer_parent_class = NULL;

GType async_bus_multiplexer_get_type (void) G_GNUC_CONST;
enum  {
	ASYNC_BUS_MULTIPLEXER_DUMMY_PROPERTY
};
gint async_bus_multiplexer_main (gchar** args, int args_length1);
AsyncBusMultiplexer* async_bus_multiplexer_new (void);
AsyncBusMultiplexer* async_bus_multiplexer_construct (GType object_type);


gint async_bus_multiplexer_main (gchar** args, int args_length1) {
	gint result = 0;
	FILE* _tmp0_ = NULL;
	_tmp0_ = stdout;
	fprintf (_tmp0_, "Async Bus - Multiplexer\n");
	result = 0;
	return result;
}


int main (int argc, char ** argv) {
#if !GLIB_CHECK_VERSION (2,35,0)
	g_type_init ();
#endif
	return async_bus_multiplexer_main (argv, argc);
}


AsyncBusMultiplexer* async_bus_multiplexer_construct (GType object_type) {
	AsyncBusMultiplexer * self = NULL;
	self = (AsyncBusMultiplexer*) g_object_new (object_type, NULL);
	return self;
}


AsyncBusMultiplexer* async_bus_multiplexer_new (void) {
	return async_bus_multiplexer_construct (ASYNC_BUS_TYPE_MULTIPLEXER);
}


static void async_bus_multiplexer_class_init (AsyncBusMultiplexerClass * klass) {
	async_bus_multiplexer_parent_class = g_type_class_peek_parent (klass);
}


static void async_bus_multiplexer_instance_init (AsyncBusMultiplexer * self) {
}


GType async_bus_multiplexer_get_type (void) {
	static volatile gsize async_bus_multiplexer_type_id__volatile = 0;
	if (g_once_init_enter (&async_bus_multiplexer_type_id__volatile)) {
		static const GTypeInfo g_define_type_info = { sizeof (AsyncBusMultiplexerClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) async_bus_multiplexer_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (AsyncBusMultiplexer), 0, (GInstanceInitFunc) async_bus_multiplexer_instance_init, NULL };
		GType async_bus_multiplexer_type_id;
		async_bus_multiplexer_type_id = g_type_register_static (G_TYPE_OBJECT, "AsyncBusMultiplexer", &g_define_type_info, 0);
		g_once_init_leave (&async_bus_multiplexer_type_id__volatile, async_bus_multiplexer_type_id);
	}
	return async_bus_multiplexer_type_id__volatile;
}



