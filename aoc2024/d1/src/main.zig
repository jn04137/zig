const std = @import("std");
const d1 = @import("d1");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var file = try std.fs.cwd().openFile("input", .{.mode = .read_only});
    defer file.close();

    var buffer: [1024]u8 = undefined;
    var reader = file.reader(&buffer);

    // iterate through each line
    while(try reader.interface.takeDelimiter('\n')) |line| {

        // Split line by left and right values
        var line_vals: std.ArrayList([]const u8) = try split_string(allocator, "   ", line);
        defer line_vals.deinit(allocator);

        const left = line_vals.items[0];

        for (left) |ele| {
            std.debug.print("element: {c} ", .{ele});
        }
        std.debug.print("\n", .{});
    }
}

fn split_string(allocator: std.mem.Allocator, delimiter: []const u8, 
    input: []u8) !std.ArrayList([]const u8) {

    // init array with size 10
    var list: std.ArrayList([]const u8) = try std.ArrayList([]const u8)
        .initCapacity(allocator, 8);

    // split the string into two with "\s\s\s" delimiter and add to list
    var val_iter = std.mem.splitSequence(u8, input, delimiter);
    while(val_iter.next()) |slice| {
        try list.append(allocator, slice);
    }

    return list;

}

