import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:storyapp/provider/story_provider.dart';
import '../provider/auth_provider.dart';
import '../widgets/story_card.dart';

class ListStoryScreen extends StatefulWidget {
  final Function(String) onTapped;
  final VoidCallback onLoggedOut;
  final VoidCallback onAddStory;
  final VoidCallback onShowLogoutDialog;

  const ListStoryScreen({
    super.key,
    required this.onTapped,
    required this.onAddStory,
    required this.onLoggedOut,
    required this.onShowLogoutDialog,
  });

  @override
  State<ListStoryScreen> createState() => _ListStoryScreenState();
}

class _ListStoryScreenState extends State<ListStoryScreen> {
  final ScrollController _scrollController = ScrollController();

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMore();
    }
  }

  Future<void> _loadStories() async {
    final authProvider = context.read<AuthProvider>();
    final storyProvider = context.read<StoryProvider>();
    final token = await authProvider.getToken();

    if (token != null) {
      storyProvider.fetchStories(token, refresh: true);
    }
  }

  Future<void> _loadMore() async {
    final authProvider = context.read<AuthProvider>();
    final storyProvider = context.read<StoryProvider>();
    final token = await authProvider.getToken();

    if (token != null && !storyProvider.isLoadingMore) {
      storyProvider.fetchStories(token);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadStories();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 32, 109, 197),
          elevation: 0,
          title: const Text(
            "Stories",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: widget.onShowLogoutDialog,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue.shade800,
          onPressed: widget.onAddStory,
          child: const Icon(Icons.add, color: Colors.white),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade400, Colors.blue.shade800],
            ),
          ),
          child: Consumer<StoryProvider>(
            builder: (context, storyProvider, child) {
              if (storyProvider.isLoading && storyProvider.stories.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }
              if (storyProvider.errorMessage != null &&
                  storyProvider.stories.isEmpty) {
                return Center(
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 64,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            storyProvider.errorMessage!,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _loadStories,
                            child: const Text("Retry"),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              if (storyProvider.stories.isEmpty) {
                return Center(
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.inbox,
                            size: 64,
                            color: Colors.blue.shade300,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "No Story Yet",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: widget.onAddStory,
                            child: const Text("Add Your First Story"),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: _loadStories,
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(
                    16,
                    kToolbarHeight + 24,
                    16,
                    16,
                  ),
                  controller: _scrollController,
                  itemCount:
                      storyProvider.stories.length +
                      (storyProvider.hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == storyProvider.stories.length) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      );
                    }

                    final story = storyProvider.stories[index];
                    return StoryCard(
                      story: story,
                      onTap: () => widget.onTapped(story.id),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
