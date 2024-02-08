#include <dbus-1.0/dbus/dbus.h>
#include <stdio.h>
#include <stdlib.h>

#define MAX_TIMEOUT 600

enum { LOW, NORMAL, CRITICAL };
#define USAGE \
	printf("Usage: %s "\
			"{Icon Path(Absolute): String} " \
			"{Summary: String} " \
			"{Body: String} " \
			"{Severity Level:(0-2)} " \
			"{Timeout: in seconds}\n" \
			"Note: HTML Tags are supported in your message\n", \
			argv[0])
#define EXT_UNEXPECTED_ARGC_CNT 1
#define EXT_UNEXPECTED_ARGV 2

int main(int argc, char **argv) {
	if (argc != 6) {
		USAGE;
		return EXT_UNEXPECTED_ARGC_CNT;
	}
	DBusConnection *connection = dbus_bus_get(DBUS_BUS_SESSION, 0);
	DBusMessage *message = dbus_message_new_method_call(
			"org.freedesktop.Notifications", "/org/freedesktop/Notifications",
			"org.freedesktop.Notifications", "Notify");
	DBusMessageIter iter[4];
	dbus_message_iter_init_append(message, iter);

	char *application = argv[0];
	dbus_message_iter_append_basic(iter, 's', &application);
	unsigned id = 0;
	dbus_message_iter_append_basic(iter, 'u', &id);
	// Setting icon
	char *icon = argv[1];
	dbus_message_iter_append_basic(iter, 's', &icon);
	// Setting notification text(supports tags)
	char *summary = argv[2];
	dbus_message_iter_append_basic(iter, 's', &summary);
	char *body = argv[3];
	dbus_message_iter_append_basic(iter, 's', &body);

	dbus_message_iter_open_container(iter, 'a', "s", iter + 1);
	dbus_message_iter_close_container(iter, iter + 1);
	dbus_message_iter_open_container(iter, 'a', "{sv}", iter + 1);
	dbus_message_iter_open_container(iter + 1, 'e', 0, iter + 2);
	char *urgency = "urgency";
	dbus_message_iter_append_basic(iter + 2, 's', &urgency);
	dbus_message_iter_open_container(iter + 2, 'v', "y", iter + 3);

	// Setting severity level
	unsigned char level;
	switch (atoi(argv[4])) {
		case 0:
			level = LOW;
			break;
		case 1:
			level = NORMAL;
			break;
		case 2:
			level = CRITICAL;
			break;
		default:
			USAGE;
			return EXT_UNEXPECTED_ARGV;
	}
	dbus_message_iter_append_basic(iter + 3, 'y', &level);
	dbus_message_iter_close_container(iter + 2, iter + 3);
	dbus_message_iter_close_container(iter + 1, iter + 2);
	dbus_message_iter_close_container(iter, iter + 1);

	// Setting notification timeout
	int timeout = atoi(argv[5]);
	if (timeout <= 0) {
		USAGE;
		return EXT_UNEXPECTED_ARGV;
	} // capping notification time
	else if (timeout > MAX_TIMEOUT) {
		printf("Given timeout, %d seconds is too large. Enter between 0 and %d\n",
				timeout, MAX_TIMEOUT);
		return EXT_UNEXPECTED_ARGV;
	} // timeout should be in ms
	else {
		timeout *= 1000;
	}

	dbus_message_iter_append_basic(iter, 'i', &timeout);
	dbus_connection_send(connection, message, 0);
	dbus_connection_flush(connection);
	dbus_message_unref(message);
	dbus_connection_unref(connection);
}
