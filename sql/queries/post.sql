-- name: CreatePost :one
INSERT INTO posts (
    id,
    created_at,
    updated_at,
    title,
    url,
    description,
    published_at,
    feed_id
    ) VALUES ( $1, $2, $3, $4, $5, $6, $7, $8 )
RETURNING *;

-- name: GetPostByUser :many
SELECT posts.* FROM posts
JOIN rss_feed_follow ON rss_feed_follow.feed_id = posts.feed_id
WHERE rss_feed_follow.user_id = $1
ORDER BY posts.published_at DESC
LIMIT $2;

