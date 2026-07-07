import XCTest
@testable import PatchBook

@MainActor
final class PatchBookTests: XCTestCase {
    var store: PatchBookStore!

    override func setUp() {
        super.setUp()
        store = PatchBookStore()
    }

    func testSeedDataLoadedOnFreshInstall() {
        XCTAssertFalse(store.entries.isEmpty)
    }

    func testSeedCountIsBelowFreeLimit() {
        XCTAssertLessThan(PatchBookStore.seedData().count, PatchBookStore.freeLimit)
    }

    func testAddEntrySucceedsUnderLimit() {
        let before = store.entries.count
        let added = store.add(PatchEntry(name: "Test Entry", detail: "Detail", date: Date()))
        XCTAssertTrue(added)
        XCTAssertEqual(store.entries.count, before + 1)
    }

    func testAddEntryFailsAtLimit() {
        while store.canAddMore {
            store.add(PatchEntry(name: "Filler", detail: "x", date: Date()))
        }
        let added = store.add(PatchEntry(name: "Overflow", detail: "x", date: Date()))
        XCTAssertFalse(added)
        XCTAssertEqual(store.entries.count, PatchBookStore.freeLimit)
    }

    func testDeleteEntry() {
        let entry = PatchEntry(name: "ToDelete", detail: "x", date: Date())
        store.add(entry)
        let before = store.entries.count
        store.delete(entry)
        XCTAssertEqual(store.entries.count, before - 1)
    }

    func testUpdateEntry() {
        var entry = PatchEntry(name: "Original", detail: "x", date: Date())
        store.add(entry)
        entry.name = "Updated"
        store.update(entry)
        XCTAssertEqual(store.entries.first(where: { $0.id == entry.id })?.name, "Updated")
    }

    func testToggleFavorite() {
        let entry = PatchEntry(name: "Fav", detail: "x", date: Date())
        store.add(entry)
        store.toggleFavorite(entry)
        XCTAssertTrue(store.entries.first(where: { $0.id == entry.id })?.isFavorite ?? false)
    }

    func testCanAddMoreReflectsLimit() {
        XCTAssertTrue(store.canAddMore)
    }
}
